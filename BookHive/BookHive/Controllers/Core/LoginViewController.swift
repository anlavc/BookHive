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
    @IBOutlet weak var bottomCons: NSLayoutConstraint!
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        xibRegister()
        setupUI()
        gestureRecognizer()
        textLocalizable()
        keyboardHidding()
        keyboardDone()
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        emailTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Enter E-mail", comment: ""), attributes: attributes)
    
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
   
    //MARK: - Keyboard Done Button
    private func keyboardDone() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: #selector(self.keyboardRemove))
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(self.keyboardRemove))
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        emailTextField.inputAccessoryView = toolBar
        passwordTextField.inputAccessoryView = toolBar
    }
    @objc func keyboardRemove() {
        view.endEditing(true)
    }
    func keyboardHidding() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(keyboardRemove))
        self.view.addGestureRecognizer(tap)
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
        loginLabelText.text                         = NSLocalizedString("Login", comment: "")
        millionsTextLabel.text                      = NSLocalizedString("To access millions of Books", comment: "")
        dontaccountTextLabel.text                   = NSLocalizedString("Don't you have an account?", comment: "")
        emailTextField.placeholder                  = NSLocalizedString("Enter E-mail adress", comment: "")
        passwordTextField.placeholder               = NSLocalizedString("Enter Password", comment: "")
        registerButton.setTitle(NSLocalizedString("Create Account", comment: ""), for: .normal)
        loginButton.setTitle(NSLocalizedString("Login", comment: ""), for: .normal)
        forgotPasswordButton.setTitle(NSLocalizedString("Forgot Password", comment: ""), for: .normal)
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
            presentGFAlertOnMainThread(title: "ERROR", message: self.validateFields()!, buttonTitle: "OK")
        } else {
            let email =     emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password =  passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                
                if error != nil {
                    
                    self.presentGFAlertOnMainThread(title: "User Login Error", message: "Please enter a valid e-mail address.", buttonTitle: "OK")
                } else {
                    if let currentUser = Auth.auth().currentUser {
                        if currentUser.isEmailVerified {
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let homeViewController = storyboard.instantiateViewController(identifier: "tabbar") as? TabBarController
                            let navigationController = UINavigationController(rootViewController: homeViewController!)
                            self.view.window?.rootViewController = navigationController
                            self.view.window?.makeKeyAndVisible()
                        } else {
                            self.presentGFAlertOnMainThread(title: "Email Verification", message: "Please verify your e-mail address to continue.", buttonTitle: "OK")
                        }
                    }
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
            return NSLocalizedString("Your Password or Mail Address is Incorrect", comment: "")
        } else {
            return nil
        }
    }
    //MARK: - Forget Button
    @IBAction func forgetButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                self.presentGFAlertOnMainThread(title: NSLocalizedString("Error Sending Password Reset Email", comment: ""), message: error.localizedDescription, buttonTitle: NSLocalizedString("OK", comment: ""))
            } else {
                self.presentGFAlertOnMainThread(title: NSLocalizedString("Password Reset Email Sent", comment: ""), message: NSLocalizedString("Check Your Email(It Maybe In Junk)", comment: ""), buttonTitle: NSLocalizedString("OK", comment: ""))
            }
        }
    }
}


