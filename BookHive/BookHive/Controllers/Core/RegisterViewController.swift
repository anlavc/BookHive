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
    
    
    @IBOutlet weak var personicon: UIButton!
    
    @IBOutlet weak var centerStack: UIStackView!
    //textfield
    @IBOutlet weak var rePassword: UITextField!
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
        gestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        self.navigationController?.isNavigationBarHidden = true
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
        personicon.layer.cornerRadius = 12
        personicon.layer.maskedCorners = [.layerMinXMinYCorner]
        lockButton.layer.cornerRadius = 12
        lockButton.layer.maskedCorners = [.layerMinXMaxYCorner]
        centerStack.addShadow(color: UIColor.darkGray, opacity: 0.5, offset: CGSize(width: 0, height: 0), radius: 5)
        createButton.addShadow(color: UIColor.darkGray, opacity: 0.5, offset: CGSize(width: 2, height: 2), radius: 5)
        password.isSecureTextEntry = true
        repassword.isSecureTextEntry = true
        
    }
    //MARK: - Login Segue
    @IBAction func backbuttonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    //MARK: - Validate Fields
    func validateFields() -> String? {
        if nickname.text!.isNilOrEmpty ||
            email.text!.isNilOrEmpty ||
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
    //MARK: - Create User
    @IBAction func createUserButton(_ sender: UIButton) {
        let error = validateFields()
        if error != nil {
            self.showAlert(title: "Warning", message: self.validateFields()!)
        } else {
            let nickname = nickname.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if  err != nil {
                    self.showAlert(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("An error occurred during registration.", comment: ""))

                } else {
                    print("*** KAYIT BAŞARILI")
                    let firestoreDatabase = Firestore.firestore()
                    var firestoreReference : DocumentReference? = nil
                    let uuid = UUID().uuidString
                    //create collection
                    let firestoreUsers =  ["name" : self.nickname.text as Any,
                                           "email" : Auth.auth().currentUser?.email as Any,
                                           "date" : FieldValue.serverTimestamp(),
                                           "uuid": uuid] as [String: Any]
                    firestoreReference = firestoreDatabase.collection("users").addDocument(data: firestoreUsers, completion: { error in
                        if error != nil {
                            self.showAlert(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("An error occurred during registration.", comment: ""))
                        } else {
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let homeViewController = storyboard.instantiateViewController(identifier: "tabbar") as? TabBarController
                            
                            self.view.window?.rootViewController = homeViewController
                            self.view.window?.makeKeyAndVisible()
                        }
                    })
                }
                
            }
        }
        
    }
    //MARK: - Login Segue Button
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
