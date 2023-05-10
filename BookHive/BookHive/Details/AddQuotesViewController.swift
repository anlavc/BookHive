//
//  AddQuotesViewController.swift
//  BookHive
//
//  Created by Anıl AVCI on 3.05.2023.
//

import UIKit
import FirebaseAuth
import Firebase

protocol AddQuotesViewControllerDelegate: AnyObject {
    func didCloseAddQuotesViewController()
}

class AddQuotesViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var notePageNumber: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var bgview: UIView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var quotesTextField: UITextView!
    //MARK: - Variables
    var authorname      : String?
    var bookName        : String?
    var coverID         : String?
    weak var delegate   : AddQuotesViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentationVc()
        keyboardDone()
        setupUI()
     
    }
    //MARK: - UI Config
    private func setupUI() {
        authorNameLabel.text = authorname
        bookNameLabel.text = bookName
        bgview.layer.cornerRadius = 20
        isModalInPresentation = true
    }
    //MARK: - Button Actions
    @IBAction func closeVC(_ sender: UIButton) {
        delegate?.didCloseAddQuotesViewController()
               dismiss(animated: true)
    }
    //MARK: - Keyboard Done Button
    private func keyboardDone() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: #selector(self.doneClicked))
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(self.doneClicked))
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        notePageNumber.inputAccessoryView = toolBar
        quotesTextField.inputAccessoryView = toolBar
    }
    @objc func doneClicked() {
        view.endEditing(true)
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
