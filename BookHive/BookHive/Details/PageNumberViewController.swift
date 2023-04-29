//
//  PageNumberViewController.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 27.04.2023.
//

import UIKit
import FirebaseAuth

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
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewsConfigure()
        setPopButton()
        userNameSetup()

    }
    
    // MARK: - Views Setup
    private func viewsConfigure() {
        bottomView.layer.cornerRadius = 15
        bottomView.addShadow(color  : .gray,
                             opacity: 0.5,
                             offset : CGSize(width: 2,
                                             height: 2),
                             radius : 0.5)
        pageNumberTF.layer.cornerRadius = 15
        pageNumberTF.addShadow(color: .gray,
                               opacity: 0.5,
                               offset: CGSize(width: 2,
                                              height: 2),
                               radius: 5)
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

    @IBAction func finishButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
    }
    
    @IBAction func offButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
}
