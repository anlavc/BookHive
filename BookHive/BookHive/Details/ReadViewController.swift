//
//  ReadViewController.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 4.05.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ReadViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var readBook : [ReadBook] = []
    
    // MARK: - Show View
    override func loadView() {
        let readView = Bundle.main.loadNibNamed("ReadViewController", owner: self)?.first as? UIView
        self.view = readView
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
  
    
    // MARK: - Table View Setup
    private func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ReadTableViewCell.nib(),
                           forCellReuseIdentifier: ReadTableViewCell.identifier)
    }
    
    // MARK: - Back Button Action
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    func readBooksRemove(index: Int) {
        if let uuid = Auth.auth().currentUser?.uid {
            let favoriteBooksCollection = Firestore.firestore().collection("users/\(uuid)/ReadsBooks")
            let coverIDToDelete = self.readBook[index].coverID
            favoriteBooksCollection.whereField("coverID", isEqualTo: coverIDToDelete).getDocuments { (snapshot, error) in
                if let error = error {
                    self.showAlert(title: "ERROR", message: "Okumaya başlama sırasında bir hata ile karşılaşıldı.")
                } else {
                    // okunuyorsa zaten okunanlardan siler.
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
    
    
    // MARK: - Swipe Delete Action Func.
    private func delete(rowIndexPathAt indexPath: IndexPath) -> UIContextualAction {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { action, view, completion in
            self.readBooksRemove(index: indexPath.row)
            self.readBook.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            completion(true)
        }
        deleteAction.backgroundColor = .systemRed
        deleteAction.image = UIImage(systemName: "trash")
        return deleteAction
    }
}

// MARK: - Extensions
extension ReadViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return readBook.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReadTableViewCell.identifier, for: indexPath) as! ReadTableViewCell
        cell.configure(book: readBook[indexPath.row])
        return cell
    }
}

extension ReadViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = self.delete(rowIndexPathAt: indexPath)
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
    }
}

