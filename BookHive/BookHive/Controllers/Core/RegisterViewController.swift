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
    //MARK: - Lİfe Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        xibRegister()
        setupUI()
        gestureRecognizer()
        textLocalizable()
    }
    //MARK: - Xib Register
    private func xibRegister() {
        Bundle.main.loadNibNamed("RegisterViewController", owner: self, options: nil)![0] as? RegisterViewController
    }
    //MARK: - Keyboard Gesture
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
            return NSLocalizedString("Your password is insufficient. \n Your password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one number, and one special character. \n Please choose a stronger password.", comment: "")
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
            self.showAlert(title: "Warning", message: self.validateFields()!)
        } else {
            let nickname    = nickname.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email       = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password    = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    self.showAlert(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("An error occurred during registration.", comment: ""))
                } else {
                    guard let uid = authResult?.user.uid else { return }
                    let userData = ["name" : self.nickname.text as Any,
                                    "email" : Auth.auth().currentUser?.email as Any,
                                    "date" : FieldValue.serverTimestamp()]
                    
                    Firestore.firestore().collection("users").document(uid).setData(userData) { error in
                        if error != nil {
                            self.showAlert(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("An error occurred during registration.", comment: ""))
                        } else {
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let homeViewController = storyboard.instantiateViewController(identifier: "tabbar") as? TabBarController
                            
                            self.view.window?.rootViewController = homeViewController
                            self.view.window?.makeKeyAndVisible()
                        }
                    }
                }
            }
            
            //            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            //                if  err != nil {
            //                    self.showAlert(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("An error occurred during registration.", comment: ""))
            //
            //                } else {
            //                    print("*** KAYIT BAŞARILI")
            //                    let firestoreDatabase = Firestore.firestore()
            //                    var firestoreReference : DocumentReference? = nil
            //                    let uuid = UUID().uuidString
            //                    //create collection
            //                    let firestoreUsers =  ["name" : self.nickname.text as Any,
            //                                           "email" : Auth.auth().currentUser?.email as Any,
            //                                           "date" : FieldValue.serverTimestamp(),
            //                                           "uuid": uuid] as [String: Any]
            //                    firestoreReference = firestoreDatabase.collection("users").addDocument(data: firestoreUsers, completion: { error in
            //                        if error != nil {
            //                            self.showAlert(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("An error occurred during registration.", comment: ""))
            //                        } else {
            //                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //                            let homeViewController = storyboard.instantiateViewController(identifier: "tabbar") as? TabBarController
            //
            //                            self.view.window?.rootViewController = homeViewController
            //                            self.view.window?.makeKeyAndVisible()
            //                        }
            //                    })
            //                }
            //
            //            }
        }
        
    }
    //MARK: - Login Segue Button
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
