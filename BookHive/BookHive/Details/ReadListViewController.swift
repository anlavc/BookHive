//
//  ReadListViewController.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 29.04.2023.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ReadListViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var favoriteBooks = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        fetchFavoriteBooks()
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
    
    
    private func setCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ReadListCollectionViewCell.nib(), forCellWithReuseIdentifier: ReadListCollectionViewCell.identifier)
    }

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension ReadListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReadListCollectionViewCell.identifier, for: indexPath) as! ReadListCollectionViewCell
        return cell
    }
}

extension ReadListViewController: UICollectionViewDelegate {
    
}

extension ReadListViewController: UICollectionViewDelegateFlowLayout {
    
}
