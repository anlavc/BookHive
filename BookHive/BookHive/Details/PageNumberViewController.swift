//
//  PageNumberViewController.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 27.04.2023.
//

import UIKit
import FirebaseAuth
import Firebase

class PageNumberViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var topView        : UIView!
    @IBOutlet weak var userNameLabel  : UILabel!
    @IBOutlet weak var bottomView     : UIView!
    @IBOutlet weak var bookImageView  : UIImageView!
    @IBOutlet weak var finishButton   : UIButton!
    @IBOutlet weak var bookNameLabel  : UILabel!
    @IBOutlet weak var progressPercent: UILabel!
    @IBOutlet weak var progressBar    : UIProgressView!
    @IBOutlet weak var pageNumberTF   : UITextField!
    @IBOutlet weak var saveButton     : UIButton!
    @IBOutlet weak var bookStartDate  : UILabel!
    @IBOutlet weak var tableView      : UITableView!
    @IBOutlet weak var infoIcon       : UIButton!
    
    //MARK: - Variable
    var selectedReadBook: ReadBook?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewsConfigure()
        setPopButton()
        setUpData()
        fetchNickname()
    }
    //MARK: - Setup UI FirebaseData
    private func setUpData() {
        bookNameLabel.text      = selectedReadBook?.title
        bookImageView.setImageOlid(with: (selectedReadBook?.coverID)!)
        bookStartDate.text      = selectedReadBook?.readingDate?.toFormattedString()
        pageNumberTF.text       = "\(selectedReadBook?.readPage! ?? 0)"
        let percentCompleted    = Double((selectedReadBook?.readPage)!) / Double(((selectedReadBook?.totalpageNumber)!)) * 100
        progressPercent.text    = "% \(Int(percentCompleted))"
        updateProgressView()
    }
    //MARK: - SetProgressView
    private func updateProgressView() {
        guard let book          = selectedReadBook else { return }
        let percentComplete     = Float(book.readPage!) / Float(book.totalpageNumber!)
        progressBar.setProgress(percentComplete, animated: true)
    }
    //MARK: - Fetch ReadingBook
    private func pageNumberDidChange() {
        guard let pageNumber    = Int(pageNumberTF.text ?? "0"),
                var book        = selectedReadBook else { return }
        if pageNumber > book.totalpageNumber! {
            showAlert(title: "Hata", message: "Girilen sayfa numarası, kitabın toplam sayfa sayısından büyük olamaz.")
            pageNumberTF.text   = "\(book.readPage!)"
            return
        } else if pageNumber    == book.totalpageNumber! {
            showAlert(title: "Tebriks", message: "Kitap bitti burdan sil okunana ekle")
            updateReadingBook(bookId: (selectedReadBook?.documentID)!)
        }
        Firestore.firestore().collection("users").document(Auth.auth().currentUser!.uid).collection("ReadsBooks").document(book.documentID!).updateData(["readPage": pageNumber]) { error in
            if let error = error {
                print("Error updating read page number: \(error.localizedDescription)")
                return
            }
            book.readPage               = pageNumber
            let percentComplete         = Float(book.readPage!) / Float(book.totalpageNumber!)
            self.progressBar.setProgress(percentComplete, animated: true)
            let percentCompletedLabel   = Double((book.readPage)!) / Double(((book.totalpageNumber)!)) * 100
            self.progressPercent.text   = "% \(Int(percentCompletedLabel))"
            self.pageNumberUpdate(bookId: (self.selectedReadBook?.documentID)!)
        }
    }
    //MARK: - FetchFirebase Nickname
    func fetchNickname() {
        guard let currentUser           = Auth.auth().currentUser else { return }
        let uid                         = currentUser.uid
        Firestore.firestore().collection("users").document(uid).getDocument { (document, error) in
            if let document             = document, document.exists {
                let name                = document.get("name") as? String ?? ""
                self.userNameLabel.text = name
            } else {
                self.userNameLabel.text = ""
            }
        }
    }
    // MARK: - Views Setup
    private func viewsConfigure() {
        bottomView.layer.cornerRadius   = 15
        bottomView.addShadow(color      : .gray,
                             opacity    : 0.5,
                             offset     : CGSize(width: 2,height: 2),
                             radius     : 0.5)
        pageNumberTF.layer.cornerRadius = 15
        pageNumberTF.addShadow(color:   .gray,
                               opacity  : 0.5,
                               offset   : CGSize(width: 2,height: 2),
                               radius   : 5)
        finishButton.layer.cornerRadius = 8
        progressBar.layer.cornerRadius  = 5
        saveButton.layer.cornerRadius   = 8
    }
    // MARK: - Setup Pop Button
    private func setPopButton() {
        let infoClosure = { (action: UIAction) in
            
        }
        self.infoIcon.menu = UIMenu(children: [
            UIAction(title: "Enter the last page you read in your book. \n Total page number \(selectedReadBook?.totalpageNumber ?? 0)", state: .off, handler: infoClosure)
        ])
        self.infoIcon.showsMenuAsPrimaryAction = true
        self.infoIcon.changesSelectionAsPrimaryAction = false
    }
    //MARK: - FinishedBook
    func updateReadingBook(bookId: String) {
        if let uuid = Auth.auth().currentUser?.uid {
            let favoriteBooksCollection = Firestore.firestore().collection("users/\(uuid)/ReadsBooks")
            let bookRef = favoriteBooksCollection.document(bookId)
            bookRef.updateData(["finish": true]) { error in
                if let error = error {
                    print("Error updating reading book: \(error.localizedDescription)")
                    return
                }
                print("Reading book updated successfully.")
            }
        }
    }
    //MARK: - Page Number Update - Click button and readPage firebase update.
    func pageNumberUpdate(bookId: String) {
        if let uuid = Auth.auth().currentUser?.uid {
            let favoriteBooksCollection = Firestore.firestore().collection("users/\(uuid)/ReadsBooks")
            let bookRef = favoriteBooksCollection.document(bookId)
            bookRef.updateData(["readPage": Int(pageNumberTF.text!)]) { error in
                if let error = error {
                    self.showAlert(title: "Error", message: "An error was encountered while updating the page number.")
                    return
                }
                let originalColor = self.pageNumberTF.backgroundColor
                    UIView.animate(withDuration: 1, animations: {
                        self.pageNumberTF.backgroundColor = UIColor(named: "addedFavoriteButton")?.withAlphaComponent(0.5)
                    }) { _ in
                        UIView.animate(withDuration: 1) {
                            self.pageNumberTF.backgroundColor = originalColor
                        }
                    }
            }
        }
    }
    
    @IBAction func finishButtonTapped(_ sender: UIButton) {
        updateReadingBook(bookId: (selectedReadBook?.documentID)!)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        DispatchQueue.main.async {
            self.pageNumberDidChange()
        }
        
    }
    
    @IBAction func offButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
}
