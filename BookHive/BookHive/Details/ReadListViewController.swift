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
                    let book = Book(coverID: coverID, title: title)
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
        cell.configure(with: favoriteBooks[indexPath.row])
        return cell
    }
}

extension ReadListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PageNumberViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
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

