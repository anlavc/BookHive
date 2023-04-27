//
//  RegisterViewController.swift
//  BookHive
//
//  Created by Anıl AVCI on 26.04.2023.
//

import UIKit

class RegisterViewController: UIViewController {
    //image
    @IBOutlet weak var imageview: UIImageView!
    
    @IBOutlet weak var personicon: UIButton!
    
    @IBOutlet weak var centerStack: UIStackView!
    //textfield
    
    @IBOutlet weak var repassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var nickname: UITextField!
    //button
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var lockButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        xibRegister()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.isNavigationBarHidden = true
    }
    private func xibRegister() {
        Bundle.main.loadNibNamed("RegisterViewController", owner: self, options: nil)![0] as? RegisterViewController
    }
    private func setupUI() {
    
        createButton.layer.cornerRadius = 5
        personicon.layer.cornerRadius = 12
        personicon.layer.maskedCorners = [.layerMinXMinYCorner]
        lockButton.layer.cornerRadius = 12
        lockButton.layer.maskedCorners = [.layerMinXMaxYCorner]
        
        centerStack.addShadow(color: UIColor.darkGray, opacity: 0.5, offset: CGSize(width: 0, height: 0), radius: 5)
        createButton.addShadow(color: UIColor.darkGray, opacity: 0.5, offset: CGSize(width: 2, height: 2), radius: 5)
        
    }

    @IBAction func backbuttonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
        print("iptal")
    }
}
