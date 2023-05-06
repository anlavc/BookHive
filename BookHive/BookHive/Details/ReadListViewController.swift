//
//  ReadListViewController.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 29.04.2023.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import Kingfisher
import Lottie

class ReadListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var animatedImage: AnimatedImageView!
    @IBOutlet weak var infoLabel: UILabel!
    
    // MARK: - Properties
    var favoriteBooks : [Book] = []
    private var viewModel = DetailViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startAnimation()
        infoLabel.isHidden = false
    }
    
    private func startAnimation() {
        if let existingView = animatedImage.subviews.first(where: {$0 is LottieAnimationView}) as? LottieAnimationView {
            existingView.play()
        } else {
            let animatedView = LottieAnimationView(name: "wantToRead")
            animatedView.contentMode = .scaleAspectFit
            animatedView.loopMode = .loop
            animatedView.center = self.animatedImage.center
            animatedView.frame = self.animatedImage.bounds
            animatedView.play()
            self.animatedImage.addSubview(animatedView)
        }
    }
    
    private func stopAnimation() {
        let animatedView = LottieAnimationView(name: "wantToRead")
        animatedView.contentMode = .scaleAspectFit
        animatedView.loopMode = .loop
        animatedView.center = self.animatedImage.center
        animatedView.frame = self.animatedImage.bounds
        animatedView.stop()
        animatedView.removeFromSuperview()
        self.animatedImage.addSubview(animatedView)
    }
    // MARK: - Table View Setup
    private func setTableView() {
        tableView.dataSource = self
        tableView.delegate   = self
        tableView.register(WantToReadTableViewCell.nib(),
                           forCellReuseIdentifier: WantToReadTableViewCell.identifier)
    }
        
    //MARK: - Favourite Books Remove Firebase
    func favoriteBookDelete(index: Int) {
        if let uuid = Auth.auth().currentUser?.uid {
            let favoriteBooksCollection = Firestore.firestore().collection("users/\(uuid)/favoriteBooks")
            let coverIDToDelete = self.favoriteBooks[index].coverID
            favoriteBooksCollection.whereField("coverID", isEqualTo: coverIDToDelete!).getDocuments { (snapshot, error) in
                if let error = error {
                    self.presentGFAlertOnMainThread(title: "ERROR", message: "Error adding a book to favorites.", buttonTitle: "OKEY")
                } else {
                    if let documents = snapshot?.documents {
                        for document in documents {
                            let bookID = document.documentID
                            favoriteBooksCollection.document(bookID).delete()
                        }
                    }
                }
            }
        }
    }
    
    //MARK: - Delete favourite book
    private func delete(rowIndexPathAt indexPath: IndexPath) -> UIContextualAction {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { action, view, completion in
            if let uuid = Auth.auth().currentUser?.uid {
                let favoriteBooksCollection = Firestore.firestore().collection("users/\(uuid)/favoriteBooks")
                let coverIDToDelete = self.favoriteBooks[indexPath.row].coverID
                favoriteBooksCollection.whereField("coverID", isEqualTo: coverIDToDelete ?? "").getDocuments { (snapshot, error) in
                    if error != nil {
                        self.presentGFAlertOnMainThread(title: "ERROR", message: "Error adding a book to favorites.", buttonTitle: "OKEY")
                    } else {
                        if let documents = snapshot?.documents {
                            for document in documents {
                                let bookID = document.documentID
                                favoriteBooksCollection.document(bookID).delete() { error in
                                    if let error = error {
                                        print("Error deleting document: \(error)")
                                    } else {
                                        self.favoriteBooks.remove(at: indexPath.row)
                                        self.tableView.deleteRows(at: [indexPath], with: .fade)
                                        self.tableView.reloadData()
                                        if self.favoriteBooks.isEmpty {
                                            self.startAnimation()
                                            self.infoLabel.isHidden = false
                                            self.animatedImage.isHidden = false
                                        }
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }
            completion(true)
        }
        deleteAction.backgroundColor = .systemRed
        deleteAction.image = UIImage(systemName: "trash")
        return deleteAction
    }
    
    //MARK: - Add the selected book to the reading list.
    private func read(rowIndexPathAt indexPath: IndexPath) -> UIContextualAction {
        let readAction = UIContextualAction(style: .normal, title: "Read") { action, view, completion in
            if let uuid = Auth.auth().currentUser?.uid {
                let favoriteBooksCollection = Firestore.firestore().collection("users/\(uuid)/ReadsBooks")
                let coverIDToDelete = self.favoriteBooks[indexPath.row].coverID
                let bookTitle = self.favoriteBooks[indexPath.row].title
                let authorName = self.favoriteBooks[indexPath.row].author
                favoriteBooksCollection.whereField("coverID", isEqualTo: coverIDToDelete!).getDocuments { (snapshot, error) in
                    if let error = error {
                        self.presentGFAlertOnMainThread(title: "ERROR", message: "An error was encountered during start reading.", buttonTitle: "OKEY")
                    } else {
                        let alert = UIAlertController(title: NSLocalizedString("Enter number of pages", comment: ""), message: nil, preferredStyle: .alert)
                        alert.addTextField()
                        let saveAction = UIAlertAction(title: NSLocalizedString("Save", comment: ""), style: .default) { (action) in
                            if let textFields = alert.textFields, let text = textFields[0].text, let numberOfPages = Int(text), numberOfPages != 0 {
                                // Kullanıcının girdiği sayı 0 değil, kaydedilebilir.
                                favoriteBooksCollection.addDocument(data:
                                    ["coverID" : coverIDToDelete!,
                                     "title"   : bookTitle!,
                                     "readPage": 0,
                                     "author"  : authorName!,
                                     "readingdate" : FieldValue.serverTimestamp(),
                                     "totalpageNumber": numberOfPages,
                                     "finish": false])
                                self.favoriteBookDelete(index: indexPath.row)
                                self.favoriteBooks.remove(at: indexPath.row)
                                self.tableView.deleteRows(at: [indexPath], with: .fade)
                                self.tableView.reloadData()
                                if self.favoriteBooks.isEmpty {
                                    self.startAnimation()
                                    self.infoLabel.isHidden = false
                                    self.animatedImage.isHidden = false
                                }
                            }
                        }
                        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
                        alert.addAction(saveAction)
                        alert.addAction(cancelAction)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            completion(true)
        }
        readAction.backgroundColor = UIColor(named: "addedFavoriteButton")
        readAction.image = UIImage(systemName: "book")
        return readAction
    }
    
    // MARK: - Back Button Action
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
}

// MARK: - Extensions
extension ReadListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WantToReadTableViewCell.identifier, for: indexPath) as! WantToReadTableViewCell
        cell.configure(book: favoriteBooks[indexPath.row])
        return cell
    }
}

extension ReadListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = self.delete(rowIndexPathAt: indexPath)
        let read = self.read(rowIndexPathAt: indexPath)
        let swipe = UISwipeActionsConfiguration(actions: [delete,read])
        return swipe
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if favoriteBooks.count > 0 {
            self.animatedImage.isHidden = true
            self.infoLabel.isHidden = true
        } else {
            self.animatedImage.isHidden = false
            self.infoLabel.isHidden = false
            self.startAnimation()
        }
    }
}
