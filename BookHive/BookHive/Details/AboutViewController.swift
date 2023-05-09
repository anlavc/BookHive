//
//  AboutViewController.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 26.04.2023.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var aboutView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfigure()
        aboutLabel.text = NSLocalizedString("Bookhive is a carefully developed digital bookmark app. Designed for those who love to read books, this app allows readers to easily locate the books they are reading. It also gives users the opportunity to learn about books. Bookhive is both a practical and useful tool and is the perfect solution for readers to keep track of their books.", comment: "") 
    }
    
    private func viewConfigure() {
        aboutView.layer.cornerRadius = 20
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
