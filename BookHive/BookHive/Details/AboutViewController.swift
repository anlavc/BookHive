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
    }
    
    private func viewConfigure() {
        aboutView.layer.cornerRadius = 20
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
