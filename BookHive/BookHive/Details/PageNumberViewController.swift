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
        userNameSetup()
        setUpData()
        fetchNickname()
    }
    //MARK: - Setup UI FirebaseData
    private func setUpData() {
        bookNameLabel.text = selectedReadBook?.title
        bookImageView.setImageOlid(with: (selectedReadBook?.coverID)!)
        bookStartDate.text = selectedReadBook?.readingDate?.toFormattedString()
        pageNumberTF.text = "\(selectedReadBook?.readPage! ?? 0)"
    }
    //MARK: - FetchFirebase Nickname
    func fetchNickname() {
        guard let currentUser = Auth.auth().currentUser else { return }
           let uid = currentUser.uid
           
           Firestore.firestore().collection("users").document(uid).getDocument { (document, error) in
               if let document = document, document.exists {
                   let name = document.get("name") as? String ?? ""
                   self.userNameLabel.text = name
               } else {
                   self.userNameLabel.text = ""
               }
           }
    }
    
    
    // MARK: - Views Setup
    private func viewsConfigure() {
        bottomView.layer.cornerRadius = 15
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
    
    private func userNameSetup() {
        //        userNameLabel.text = Auth.auth().currentUser?.displayName
    }
    
    // MARK: - Setup Pop Button
    private func setPopButton() {
        let infoClosure = { (action: UIAction) in
            
        }
        self.infoIcon.menu = UIMenu(children: [
            UIAction(title: "Enter the last page you read in your book.", state: .off, handler: infoClosure)
        ])
        self.infoIcon.showsMenuAsPrimaryAction = true
        self.infoIcon.changesSelectionAsPrimaryAction = false
    }
    //MARK: - FinishBook
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
    //MARK: - PageNumberUpdate
    func pageNumberUpdate(bookId: String) {
        if let uuid = Auth.auth().currentUser?.uid {
            let favoriteBooksCollection = Firestore.firestore().collection("users/\(uuid)/ReadsBooks")
            let bookRef = favoriteBooksCollection.document(bookId)
            bookRef.updateData(["readPage": Int(pageNumberTF.text!)]) { error in
                if let error = error {
                    print("Error updating reading book: \(error.localizedDescription)")
                    return
                }
                print("Reading book updated successfully.")
            }
        }
    }
    
    @IBAction func finishButtonTapped(_ sender: UIButton) {
        updateReadingBook(bookId: (selectedReadBook?.documentID)!)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        pageNumberUpdate(bookId: (selectedReadBook?.documentID)!)
    }
    
    @IBAction func offButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
}
