//
//  LoginViewController.swift
//  BookHive
//
//  Created by Anıl AVCI on 26.04.2023.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {
    let myView = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 100))
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
    //label
    @IBOutlet weak var loginLabelText: UILabel!
    
    @IBOutlet weak var millionsTextLabel: UILabel!
    @IBOutlet weak var dontaccountTextLabel: UILabel!
    
    
    
    override func viewDidLoad() {
           super.viewDidLoad()
           xibRegister()
           setupUI()
           gestureRecognizer()
         
   //        let myLabel = UILabel(frame: CGRect(x: 0, y: 0, width: myView.frame.width, height: myView.frame.height))
   //        myLabel.text = "Bu, animasyonlu olarak gösterilecek 3-4 satırlık yazıdır."
   //        myLabel.numberOfLines = 4
   //        myView.addSubview(myLabel)

       }
       
       //MARK: - Xib Register
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
           passwordTextField.isSecureTextEntry = true
           //localize
           loginButton.titleLabel?.text 			= NSLocalizedString("Login", comment: "")
           loginLabelText.text 						= NSLocalizedString("LOGIN", comment: "")
           millionsTextLabel.text 					= NSLocalizedString("To access millions of Books", comment: "")
           forgotPasswordButton.titleLabel?.text 	= NSLocalizedString("Forget Password?", comment: "")
           dontaccountTextLabel.text 				= NSLocalizedString("Hesabınız yok mu?", comment: "")
           registerButton.titleLabel?.text 			= NSLocalizedString("Create Account", comment: "")
           emailTextField.placeholder               = NSLocalizedString("Enter E-mail adress", comment: "")
           passwordTextField.placeholder            = NSLocalizedString("Enter Password", comment: "")
       }
       override func viewWillAppear(_ animated: Bool) {
           self.navigationController?.isNavigationBarHidden = true
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
               let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
               let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
               
               Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                   
                   if error != nil {
                       self.showAlert(title: NSLocalizedString("User login error", comment: ""), message: "\(error!.localizedDescription)")
                       
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
       
       @IBAction func forgetButtonTapped(_ sender: UIButton) {
           myView.frame.origin.y = self.view.frame.height - myView.frame.height
                   self.view.addSubview(myView)
                   
                   UIView.animate(withDuration: 0.3) {
                       self.myView.frame.origin.y = self.view.frame.height - self.myView.frame.height
                   }


       }
   }

