//
//  RegisterViewController.swift
//  BookHive
//
//  Created by Anıl AVCI on 26.04.2023.
//

import UIKit
import FirebaseAuth
import Firebase

class RegisterViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var personicon: UIButton!
    @IBOutlet weak var centerStack: UIStackView!
    @IBOutlet weak var rePassword: UITextField!
    @IBOutlet weak var repassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var nickname: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var lockButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var createAccount: UILabel!
    @IBOutlet weak var haveAccount: UILabel!
    @IBOutlet weak var privacyTextField: UITextView!
    @IBOutlet weak var termsLabel: UILabel!
    
    //MARK: - Lİfe Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        xibRegister()
        setupUI()
        gestureRecognizer()
        textLocalizable()
        termsLabelConfig()
        keyboardDone()
    }
    //MARK: - Privacy Policy
    private func termsLabelConfig() {
        let attributedString = NSMutableAttributedString(string: NSLocalizedString("By continuing, you acknowledge that you have read and accepted BookHive - Bookmark & Quotes' Terms of Service.", comment: "") )
        
        let buttonRange = attributedString.mutableString.range(of: NSLocalizedString("Terms of Service", comment: "") )
        if buttonRange.location != NSNotFound {
            attributedString.addAttribute(.link, value: "https://docs.google.com/document/d/e/2PACX-1vR6cDqVe_j5rbOEKBNu5ai4yXBK0NO9uKNInfxzsoc0RfLqZt5RBxlYYKd1ZByz4gkvPZP9we5ho4hv/pub", range: buttonRange)
        }
        termsLabel.attributedText = attributedString
        termsLabel.isUserInteractionEnabled = true
        termsLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(termsLabelTapped)))
    }
    @objc func termsLabelTapped() {
        if let url = URL(string: "https://docs.google.com/document/d/e/2PACX-1vR6cDqVe_j5rbOEKBNu5ai4yXBK0NO9uKNInfxzsoc0RfLqZt5RBxlYYKd1ZByz4gkvPZP9we5ho4hv/pub") {
            UIApplication.shared.open(url)
        }
    }


    //MARK: - Xib Register
    private func xibRegister() {
        Bundle.main.loadNibNamed("RegisterViewController", owner: self, options: nil)![0] as? RegisterViewController
    }
    //MARK: - Keyboard Done Button
    private func keyboardDone() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace               = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: #selector(self.dismissKeyboard))
        let doneButton                  = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(self.dismissKeyboard))
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        nickname.inputAccessoryView     = toolBar
        email.inputAccessoryView        = toolBar
        password.inputAccessoryView     = toolBar
        repassword.inputAccessoryView   = toolBar
    }
    private func gestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupUI() {
        createButton.layer.cornerRadius = 5
        personicon.layer.cornerRadius   = 12
        personicon.layer.maskedCorners  = [.layerMinXMinYCorner]
        lockButton.layer.cornerRadius   = 12
        lockButton.layer.maskedCorners  = [.layerMinXMaxYCorner]
        centerStack.addShadow(color: UIColor.darkGray, opacity: 0.5, offset: CGSize(width: 0, height: 0), radius: 0)
        createButton.addShadow(color: UIColor.darkGray, opacity: 0.5, offset: CGSize(width: 2, height: 2), radius: 5)
        let attributes                              = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        nickname.attributedPlaceholder        = NSAttributedString(string: NSLocalizedString("Enter Name", comment: ""), attributes: attributes)
        email.attributedPlaceholder     = NSAttributedString(string: NSLocalizedString("Enter E-mail", comment: ""), attributes: attributes)
        password.attributedPlaceholder     = NSAttributedString(string: NSLocalizedString("Enter Password", comment: ""), attributes: attributes)
        repassword.attributedPlaceholder     = NSAttributedString(string: NSLocalizedString("Enter Password", comment: ""), attributes: attributes)
    }
    
    //MARK: - String Localizable
    private func textLocalizable() {
        nickname.placeholder    = NSLocalizedString("Enter Name", comment: "")
        email.placeholder       = NSLocalizedString("Enter E-mail", comment: "")
        password.placeholder    = NSLocalizedString("Enter Password", comment: "")
        repassword.placeholder  = NSLocalizedString("Re-Enter Password", comment: "")
        haveAccount.text        = NSLocalizedString("Already have an account?", comment: "")
        createAccount.text      = NSLocalizedString("CREATE ACCOUNT", comment: "")
        createButton.setTitle(NSLocalizedString("Register", comment: ""), for: .normal)
        loginButton.setTitle(NSLocalizedString("Login", comment: ""), for: .normal)
        
    }
    
    //MARK: - Login Segue
    @IBAction func backbuttonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    //MARK: - Validate Fields
    private func validateFields() -> String? {
        if nickname.text!.isNilOrEmpty  ||
            email.text!.isNilOrEmpty    ||
            password.text!.isNilOrEmpty ||
            repassword.text!.isNilOrEmpty {
            return NSLocalizedString("Please enter your username, nickname and password for registration.", comment: "")
            
        } else if Utilities.isValidEmail(email: email.text!) == false {
            return NSLocalizedString("Please enter your e-mail address correctly.", comment: "")
        } else if Utilities.isPasswordValid(password.text!) == false {
            password.layer.borderColor = UIColor.red.cgColor
            return NSLocalizedString("Your password must be at least 6 characters long. \n and contain at least 1 lowercase letter, 1 uppercase letter, 1 number and 1 special character.", comment: "")
        } else if  password.text != repassword.text {
            return NSLocalizedString("Password did not match", comment: "")
        } else {
            return nil
        }
    }
    
    //MARK: - Firebase Create User
    @IBAction func createUserButton(_ sender: UIButton) {
        let error = validateFields()
        if error != nil {
            self.presentGFAlertOnMainThread(title: "WARNING", message: self.validateFields()!, buttonTitle: "OK")
        } else {
            let email       = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password    = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if error != nil {
                    self.presentGFAlertOnMainThread(title: "ERROR", message: "An error occurred during registration.", buttonTitle: "OK")
                } else {
                    guard let uid = authResult?.user.uid else { return }
                    // Kullanıcının e-posta adresini doğrula
                    Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                        if error != nil {
                            self.presentGFAlertOnMainThread(title: "ERROR", message: "An error occurred while sending verification email.", buttonTitle: "OK")
                        } else {
                            self.presentGFAlertOnMainThread(title: "SUCCESS", message: "Verification email sent successfully. Please check your inbox and click on the verification link to verify your email address.", buttonTitle: "OK")
                        }
                    })
                    let userData = ["name" : self.nickname.text as Any,
                                    "email" : Auth.auth().currentUser?.email as Any,
                                    "date" : FieldValue.serverTimestamp()]
                    
                    Firestore.firestore().collection("users").document(uid).setData(userData) { error in
                        if error != nil {
                            self.presentGFAlertOnMainThread(title: "ERROR", message: "An error occurred during registration.", buttonTitle: "OK")
                        } else {
                            do {
                                try Auth.auth().signOut()
                            } catch let signOutError as NSError {
                                print ("Error signing out: %@", signOutError)
                            }
                            
                            self.dismiss(animated: true)
                        }
                    }
                }
            }
        }
    }
    //MARK: - Login Segue Button
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
