//
//  ReadListViewController.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 29.04.2023.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ReadListViewController: UIViewController,ReadListCollectionViewCellDelegate {
    func deleteItem(indexPath: IndexPath) {
        if let uuid = Auth.auth().currentUser?.uid {
            let favoriteBooksCollection = Firestore.firestore().collection("users/\(uuid)/favoriteBooks")
            let book = favoriteBooks[indexPath.row]
            favoriteBooksCollection.document(book.coverID ?? "").delete() { error in
                if error != nil {
                    return
                }
                self.favoriteBooks.remove(at: indexPath.row)
                self.collectionView.performBatchUpdates({
                    self.collectionView.deleteItems(at: [indexPath])
                }, completion: { success in
                    if self.favoriteBooks.isEmpty {
                        self.collectionView.reloadData()
                    }
                })
            }
        }
    }

    @IBOutlet weak var collectionView: UICollectionView!
    
    var favoriteBooks = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        fetchFavoriteBooks()
    }
    
    private func setCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ReadListCollectionViewCell.nib(), forCellWithReuseIdentifier: ReadListCollectionViewCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
    }
    
    private func fetchFavoriteBooks() {
        if let uuid = Auth.auth().currentUser?.uid { // kullanıcının id sine ulaştım
            let favoriteBooksCollection = Firestore.firestore().collection("users/\(uuid)/favoriteBooks") //kullanıcıya özel oluşturulmuş collectiona ulaştım
            favoriteBooksCollection.getDocuments { (querySnapshot, error) in //kullanıcının collection ın dökümanına erişiyorum
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                guard let documents = querySnapshot?.documents else {
                    self.showAlert(title: "error", message: "No Favorite Books Found")
                    return
                }
                var books = [Book]()
                for document in documents {
                    let coverID = document.data()["coverID"] as! String
                    let title = document.data()["title"] as! String
                    let author = document.data()["author"] as? String
                    let book = Book(coverID: coverID, title: title, author: author)
                    books.append(book)
                }
                self.favoriteBooks = books
                self.collectionView.reloadData()
            }
        }
    }

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension ReadListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteBooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReadListCollectionViewCell.identifier, for: indexPath) as! ReadListCollectionViewCell
        cell.indexPath = indexPath
        cell.delegate = self
        cell.book = favoriteBooks[indexPath.row]
        cell.configure(model: favoriteBooks[indexPath.row])
        return cell
    }
}

extension ReadListViewController: UICollectionViewDelegate {
   
}

extension ReadListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.bounds.width) / 2.2
        let cellHeight = cellWidth * 1.7
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}


