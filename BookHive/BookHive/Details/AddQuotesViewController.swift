//
//  AddQuotesViewController.swift
//  BookHive
//
//  Created by Anıl AVCI on 3.05.2023.
//

import UIKit
import FirebaseAuth
import Firebase

class AddQuotesViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var notePageNumber: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var bgview: UIView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var quotesTextField: UITextView!
    //MARK: - Variables
    var authorname: String?
    var bookName: String?
    var coverID: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentationVc()
        authorNameLabel.text = authorname
        bookNameLabel.text = bookName
        bgview.layer.cornerRadius = 20
        
        
    }
    //MARK: - Quotes save button
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        saveQuotesNotes()
    }
    //MARK: - Add Favorite and Remove Favorite
    func saveQuotesNotes() {
        if let uuid = Auth.auth().currentUser?.uid {
            let favoriteBooksCollection = Firestore.firestore().collection("users/\(uuid)/QuotesBooks")
            
            favoriteBooksCollection.addDocument(data: ["coverID"        : coverID!,
                                                       "quotesNote"     : quotesTextField.text,
                                                       "title"          : bookName!,
                                                       "author"         : authorname!,
                                                       "notePageNumber" : notePageNumber.text!,
                                                       "readingdate"    : FieldValue.serverTimestamp()
                                                      ])
            presentGFAlertOnMainThread(title: "Success", message: "Notes Success Added", buttonTitle: "OK")
            
            guard let pageNumberVC = presentingViewController as? PageNumberViewController else {return}
            pageNumberVC.quotesBooksFetch(forCoverId: coverID!)
            pageNumberVC.collectionView.reloadData()
            dismiss(animated: true)
          
        }
    }
    
    
    
    //MARK: - BottomForm Medium
    private func presentationVc() {
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [
                .medium()
            ]
        }
    }
    
}
