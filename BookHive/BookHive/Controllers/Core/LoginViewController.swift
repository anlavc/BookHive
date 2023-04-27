//
//  LoginViewController.swift
//  BookHive
//
//  Created by Anıl AVCI on 26.04.2023.
//

import UIKit

class LoginViewController: UIViewController {

    //textfield
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    //button
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    //view
    @IBOutlet weak var formbgView: UIView!
    //image
    @IBOutlet weak var personicon: UIButton!
    @IBOutlet weak var lockicon: UIButton!

    @IBOutlet weak var centerStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        xibRegister()
        setupUI()
     
    }


    private func xibRegister() {
        Bundle.main.loadNibNamed("LoginViewController", owner: self, options: nil)![0] as? LoginViewController
    }
    //MARK: - UI Configuration
    private func setupUI() {
        personicon.layer.cornerRadius = 12
        loginButton.layer.cornerRadius = 5
        personicon.layer.maskedCorners = [.layerMinXMinYCorner]
        lockicon.layer.cornerRadius = 12
        lockicon.layer.maskedCorners = [.layerMinXMaxYCorner]
        centerStack.addShadow(color: UIColor.darkGray, opacity: 0.5, offset: CGSize(width: 0, height: 0), radius: 5)
        loginButton.addShadow(color: UIColor.darkGray, opacity: 0.5, offset: CGSize(width: 2, height: 2), radius: 5)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        let vc = RegisterViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}
