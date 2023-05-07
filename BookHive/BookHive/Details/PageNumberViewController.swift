//
//  PageNumberViewController.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 27.04.2023.
//

import UIKit
import FirebaseAuth
import Firebase
import Kingfisher

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
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var infoIcon       : UIButton!
    @IBOutlet weak var addQuotesButton: UIButton!
    @IBOutlet weak var animatedView: AnimatedImageView!
    @IBOutlet weak var quotesAnimateLabel: UILabel!

    //MARK: - Variable
    var selectedReadBook: ReadBook?
    var quotesNotes     : [QuotesNote] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewsConfigure()
        setPopButton()
        setUpData()
        fetchNickname()
        collectionSetup()
        gestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        quotesBooksFetch(forCoverId: (selectedReadBook?.coverID)!)
    }
    
    //MARK: - Setup UI FirebaseData
    private func setUpData() {
        bookNameLabel.text      = selectedReadBook?.title
        bookImageView.setImageOlid(with: (selectedReadBook?.coverID)!)
        bookStartDate.text      = selectedReadBook?.readingDate?.toFormattedString()
//        pageNumberTF.text       = "\(selectedReadBook?.readPage! ?? 0)"
        let percentCompleted    = Double((selectedReadBook?.readPage)!) / Double(((selectedReadBook?.totalpageNumber)!)) * 100
        progressPercent.text    = "% \(Int(percentCompleted))"
        updateProgressView()
    }
    
    //MARK: - CollectionView Setup
    private func collectionSetup() {
        collectionView.register(MyquotesCollectionViewCell.nib(), forCellWithReuseIdentifier: MyquotesCollectionViewCell.identifier)
        collectionView.delegate     = self
        collectionView.dataSource   = self
    }
    //MARK: - SetProgressView
    private func updateProgressView() {
        guard let book          = selectedReadBook else { return }
        let percentComplete     = Float(book.readPage!) / Float(book.totalpageNumber!)
        progressBar.setProgress(percentComplete, animated: true)
    }
    
    //MARK: - Keyboard Gesture
    private func gestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: - Fetch ReadingBook
    private func pageNumberDidChange() {
        guard let pageNumber    = Int(pageNumberTF.text ?? "0"),
              var book        = selectedReadBook else { return }
        if pageNumber > book.totalpageNumber! {
            presentGFAlertOnMainThread(title: "WARNING", message: "The page number entered cannot be greater than the total page number.", buttonTitle: "TAMAM")
            pageNumberTF.text   = "\(book.readPage!)"
            return
        } else if pageNumber    == book.totalpageNumber! {
            presentGFAlertOnMainThread(title: "CONGRATULATIONS", message: "Congratulations. The book is finished.  Now this book will be listed among the reads.", buttonTitle: "OKEY")
            readingBookFinishUpdate(bookId: (selectedReadBook?.documentID)!)
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
            self.pageNumberTF.text = ""
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
        bottomView.layer.cornerRadius       = 15
        bottomView.addShadow(color          : .gray,
                             opacity        : 0.5,
                             offset         : CGSize(width: 2,height: 2),
                             radius         : 0.5)
        pageNumberTF.layer.cornerRadius     = 15
        pageNumberTF.addShadow(color:       .gray,
                               opacity      : 0.5,
                               offset       : CGSize(width: 2,height: 2),
                               radius       : 5)
        finishButton.layer.cornerRadius     = 8
        addQuotesButton.layer.cornerRadius  = 8
        progressBar.layer.cornerRadius      = 5
        saveButton.layer.cornerRadius       = 8
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
    
    //MARK: - The finish value is updated to true if the book is finished
    func readingBookFinishUpdate(bookId: String) {
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
                    self.presentGFAlertOnMainThread(title: "ERROR", message: "An error was encountered while updating the page number.", buttonTitle: "OK")
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
    
    //MARK: - Fetch a request to see quotes related to the book
     func quotesBooksFetch(forCoverId coverId: String) {
        if let uuid = Auth.auth().currentUser?.uid {
            let favoriteBooksCollection = Firestore.firestore().collection("users/\(uuid)/QuotesBooks")
            favoriteBooksCollection.whereField("coverID", isEqualTo: coverId).getDocuments() { (querySnapshot, error) in
                if let error = error {
                    print("Error fetching favorite books: \(error.localizedDescription)")
                    return
                }
                guard let documents = querySnapshot?.documents else {
                    self.presentGFAlertOnMainThread(title: "ERROR", message: "No result found.", buttonTitle: "OK")
                    return
                }
                self.quotesNotes.removeAll()
                for document in documents {
                    let documentID                  = document.documentID
                    let coverID                     = document.data()["coverID"] as? String
                    let quotesNote                  = document.data()["quotesNote"] as? String
                    let title                       = document.data()["title"] as? String
                    let author                      = document.data()["author"] as? String
                    let notePageNumber              = document.data()["notePageNumber"] as? String
                    let readPage                    = document.data()["readPage"] as? Int
                    let readingDateTimestamp        = document.data()["readingdate"] as? Timestamp
                    let readingDate                 = readingDateTimestamp?.dateValue()
                    let quotesNoteBook   = QuotesNote(title: title, author: author, notePageNumber: notePageNumber, quotesNote: quotesNote, noteDate: readingDate)
                    self.quotesNotes.append(quotesNoteBook) // gelen veri quotesNotes dizisine eklenir.
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    //MARK: - Button actions
    @IBAction func finishButtonTapped(_ sender: UIButton) {
        presentBottomAlert(title: "", message: "Are you sure you want to add this book to your reading list?", okTitle: "Done", cancelTitle: "CANCEL") {
            [self] in
            self.readingBookFinishUpdate(bookId: (selectedReadBook?.documentID)!)
            dismiss(animated: true)
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        DispatchQueue.main.async {
            self.pageNumberDidChange()
        }
    }
    
    @IBAction func offButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func addQuotesButtonTapped(_ sender: UIButton) {
        let vc = AddQuotesViewController()
        // present yaparken kitap adı ve yazar bilgileri belli olduğunda alıntı ekleme sayfasına buradan bilgiler gönderilir.
        vc.authorname  = selectedReadBook?.author
        vc.bookName = selectedReadBook?.title
        vc.coverID = selectedReadBook?.coverID
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true)
    }
}

extension PageNumberViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if quotesNotes.count == 0 {
            return 1
        }
        return quotesNotes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyquotesCollectionViewCell.identifier, for: indexPath) as! MyquotesCollectionViewCell
        if quotesNotes.count == 0 {
            cell.setupNil()
  
        } else {
            cell.setup(note: quotesNotes[indexPath.row])
        }
        return cell
    }
   
}
