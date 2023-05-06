//
//  LicenseViewController.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 7.05.2023.
//

import UIKit

class LicenseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func uxwing(_ sender: UIButton) {
        if let url = URL(string: "https://uxwing.com/license/") {
            UIApplication.shared.open(url, completionHandler: nil)
        }
    }
    
    @IBAction func lottie(_ sender: UIButton) {
        if let url = URL(string: "https://lottiefiles.com/page/license") {
            UIApplication.shared.open(url, completionHandler: nil)
        }
    }
    
    @IBAction func open(_ sender: UIButton) {
        if let url = URL(string: "https://openlibrary.org/developers/licensing") {
            UIApplication.shared.open(url, completionHandler: nil)
        }
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
}
