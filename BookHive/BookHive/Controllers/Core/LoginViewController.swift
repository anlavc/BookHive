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
       //MARK: - Button Tapped
       @IBAction func registerButtonTapped(_ sender: UIButton) {
           let vc = RegisterViewController()
           vc.modalPresentationStyle = .fullScreen
           present(vc, animated: true)
       }
       @IBAction func loginButtonTapped(_ sender: UIButton) {
           let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
           let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
           
           Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
               
               if error != nil {
                   print("GİRİŞTE HATA VAR \(error?.localizedDescription)")
                   
               } else {
                   let storyboard = UIStoryboard(name: "Main", bundle: nil)
                   let homeViewController = storyboard.instantiateViewController(identifier: "tabbar") as? TabBarController
                   
                   self.view.window?.rootViewController = homeViewController
                   self.view.window?.makeKeyAndVisible()
               }
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

