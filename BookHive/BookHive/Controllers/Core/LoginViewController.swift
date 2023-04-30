//
//  LoginViewController.swift
//  BookHive
//
//  Created by Anıl AVCI on 26.04.2023.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var formbgView: UIView!
    @IBOutlet weak var personicon: UIButton!
    @IBOutlet weak var lockicon: UIButton!
    @IBOutlet weak var centerStack: UIStackView!
    @IBOutlet weak var loginLabelText: UILabel!
    @IBOutlet weak var millionsTextLabel: UILabel!
    @IBOutlet weak var dontaccountTextLabel: UILabel!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        xibRegister()
        setupUI()
        gestureRecognizer()
        textLocalizable()
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        emailTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Enter E-mail", comment: ""), attributes: attributes)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: - Xib Register
    private func xibRegister() {
        Bundle.main.loadNibNamed("LoginViewController", owner: self, options: nil)![0] as? LoginViewController
    }
    //MARK: - UI Configuration
    private func setupUI() {
        personicon.layer.cornerRadius               = 12
        loginButton.layer.cornerRadius              = 5
        lockicon.layer.cornerRadius                 = 12
        lockicon.layer.maskedCorners                = [.layerMinXMaxYCorner]
        personicon.layer.maskedCorners              = [.layerMinXMinYCorner]
        centerStack.addShadow(color: UIColor.darkGray, opacity: 0.5, offset: CGSize(width: 0, height: 0), radius: 0)
        loginButton.addShadow(color: UIColor.darkGray, opacity: 0.5, offset: CGSize(width: 2, height: 2), radius: 5)
        let attributes                              = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        emailTextField.attributedPlaceholder        = NSAttributedString(string: NSLocalizedString("Enter E-mail", comment: ""), attributes: attributes)
        passwordTextField.attributedPlaceholder     = NSAttributedString(string: NSLocalizedString("Re-Enter Password", comment: ""), attributes: attributes)

    }
    //MARK: - Functions
    
    private func textLocalizable() {
        loginLabelText.text                         = NSLocalizedString("LOGIN", comment: "")
        millionsTextLabel.text                      = NSLocalizedString("To access millions of Books", comment: "")
        dontaccountTextLabel.text                   = NSLocalizedString("Hesabınız yok mu?", comment: "")
        emailTextField.placeholder                  = NSLocalizedString("Enter E-mail adress", comment: "")
        passwordTextField.placeholder               = NSLocalizedString("Enter Password", comment: "")
        registerButton.setTitle(NSLocalizedString("Create Account", comment: ""), for: .normal)
        loginButton.setTitle(NSLocalizedString("Login", comment: ""), for: .normal)
        forgotPasswordButton.setTitle(NSLocalizedString("Forgot Password?", comment: ""), for: .normal)
    }
 
    //MARK: - Keyboard Gesture
    private func gestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    //MARK: - Register Button
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        let vc = RegisterViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    //MARK: - Login Button
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let error = validateFields()
        if error != nil {
            showAlert(title: NSLocalizedString("Error", comment: ""), message: self.validateFields()!)
        } else {
            let email =     emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password =  passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                
                if error != nil {
                    self.showAlert(title: NSLocalizedString("User login error", comment: ""), message: NSLocalizedString("Please enter a valid e-mail address.", comment: ""))
                    
                } else {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let homeViewController = storyboard.instantiateViewController(identifier: "tabbar") as? TabBarController
                    self.view.window?.rootViewController = homeViewController
                    self.view.window?.makeKeyAndVisible()
                }
            }
        }
    }
    //MARK: - Validate Button
    func validateFields() -> String? {
        if emailTextField.text!.isNilOrEmpty ||
            passwordTextField.text!.isNilOrEmpty {
            return NSLocalizedString("Email or password field is empty", comment: "")
            
        } else if Utilities.isValidEmail(email: emailTextField.text!) == false {
            return NSLocalizedString("Please enter your e-mail address correctly.", comment: "")
        } else if Utilities.isPasswordValid(passwordTextField.text!) == false {
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            return NSLocalizedString("Your password is insufficient. \n Your password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one number, and one special character. \n Please choose a stronger password.", comment: "")
        } else {
            return nil
        }
    }
    //MARK: - Forgot Button
    @IBAction func forgetButtonTapped(_ sender: UIButton) {
        
        
    }
}

