//
//  MyBooksViewController.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 12.04.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class MyBooksViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var wantToReadView: UIView!
    @IBOutlet weak var readView      : UIView!
    @IBOutlet weak var wantReadLabel: UILabel!
    @IBOutlet weak var readBookLabel: UILabel!
    // MARK: - Properties
    var readingBooks: [ReadBook] = []
    var favoriteBooks: [Book] = []
    var finishBook: [ReadBook] = []
    
    // MARK: - Load View
    override func loadView() {
        let mybooksView = Bundle.main.loadNibNamed("MyBooksViewController",
                                                   owner: self)?.first as! UIView
        self.view       = mybooksView
        
        
    }
   
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewSetup()
        viewsSetup()
        tapGestureViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchReadingBooks()
        fetchFavoriteBooks()
    }
    
    //MARK: - Set Tap Gesture
    private func tapGestureViews() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(wantToReadViewTapped))
        wantToReadView.addGestureRecognizer(tapGesture)
        let readTapGesture = UITapGestureRecognizer(target: self, action: #selector(ReadViewTapped))
        readView.addGestureRecognizer(readTapGesture)
    }
    
    //MARK: - Firebase favorite Book fetch func
     func fetchFavoriteBooks() {
        if let uuid = Auth.auth().currentUser?.uid {
            let favoriteBooksCollection = Firestore.firestore().collection("users/\(uuid)/favoriteBooks")
            favoriteBooksCollection.getDocuments() { (querySnapshot, error) in
                if let error = error {
                    print("Error fetching favorite books: \(error.localizedDescription)")
                    return
                }
                guard let documents = querySnapshot?.documents else {
                    self.showAlert(title: "hata", message: "No favorite books found.")
                    return
                }
                self.favoriteBooks.removeAll()
                for document in documents {
                    let coverID     = document.data()["coverID"] as! String
                    let title       = document.data()["title"] as! String
                    let author      = document.data()["author"] as? String
                    let book        = Book(coverID: coverID, title: title,author: author)
                    self.favoriteBooks.append(book)
                    DispatchQueue.main.async {
                        self.wantReadLabel.text = "Books (\(self.favoriteBooks.count))"
                        self.readBookLabel.text = "Books (\(self.finishBook.count))"
                    }
                }
            }
        }
    }
//MARK: - Fetch ReadingBook
    private func fetchReadingBooks() {
        if let uuid = Auth.auth().currentUser?.uid {
            let favoriteBooksCollection = Firestore.firestore().collection("users/\(uuid)/ReadsBooks")
            favoriteBooksCollection.order(by: "readingdate",descending: true).getDocuments() { (querySnapshot, error) in
                if let error = error {
                    print("Error fetching favorite books: \(error.localizedDescription)")
                    return
                }
                guard let documents = querySnapshot?.documents else {
                    self.showAlert(title: "hata", message: "No read books found.")
                    return
                }
                self.readingBooks.removeAll()
                self.finishBook.removeAll()
                for document in documents {
                    let documentID      = document.documentID
                    let coverID         = document.data()["coverID"] as! String
                    let title           = document.data()["title"] as! String
                    let finish          = document.data()["finish"] as! Bool
                    let readPage        = document.data()["readPage"] as! Int
                    let readingDateTimestamp     = document.data()["readingdate"] as? Timestamp
                    let readingDate = readingDateTimestamp?.dateValue()
                    let author          = document.data()["author"] as? String
                    let totalpageNumber = document.data()["totalpageNumber"] as! Int
                    if !finish {
                        let readbookArray   = ReadBook(coverID: coverID, title: title, finish: finish, readPage: readPage, readingDate: readingDate, totalpageNumber: totalpageNumber, author: author,documentID: documentID)
                        self.readingBooks.append(readbookArray)
                    } else {
                        let readbookArray   = ReadBook(coverID: coverID, title: title, finish: finish, readPage: readPage, readingDate: readingDate, totalpageNumber: totalpageNumber, author: author,documentID: documentID)
                        self.finishBook.append(readbookArray)
                    }
                    self.collectionView.reloadData()
                    
                    
                }
            }
        }
    }
    // MARK: - Collection View Configure
    private func collectionViewSetup() {
        let layout                          = UICollectionViewFlowLayout()
        layout.scrollDirection              = .horizontal
        layout.minimumLineSpacing           = 10
        layout.minimumInteritemSpacing      = 10
        layout.sectionInset                 = UIEdgeInsets(top   : 10,
                                                           left  : 10,
                                                           bottom: 10,
                                                           right : 10)
        collectionView.collectionViewLayout = layout
        collectionView.dataSource           = self
        collectionView.delegate             = self
        collectionView.register(MyBooksCollectionViewCell.nib(),
                                forCellWithReuseIdentifier: MyBooksCollectionViewCell.identifier)
    }
    
    // MARK: - Views Setup
    private func viewsSetup() {
        wantToReadView.layer.cornerRadius = 15
        wantToReadView.addShadow(color: .gray,
                                 opacity: 0.5,
                                 offset: CGSize(width : 2,
                                                height: 2),
                                 radius: 5)
        readView.layer.cornerRadius = 15
        readView.addShadow(color: .gray,
                           opacity: 0.5,
                           offset: CGSize(width : 2,
                                          height: 2),
                           radius: 5)
    }
    
    @objc public func wantToReadViewTapped() {
        let vc = ReadListViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc public func ReadViewTapped() {
        let vc = ReadViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}

// MARK: - Extensions
extension MyBooksViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return readingBooks.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyBooksCollectionViewCell.identifier, for: indexPath) as! MyBooksCollectionViewCell
        cell.setup(book: readingBooks[indexPath.row])
        return cell
    }
}

extension MyBooksViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PageNumberViewController()
        vc.selectedReadBook = readingBooks[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

extension MyBooksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width : 300,
                      height: 150)
    }
}
