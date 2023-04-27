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
    //MARK: - Login Segue
    @IBAction func backbuttonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
        print("iptal")
    }
    //MARK: - Create User
    @IBAction func createUserButton(_ sender: UIButton) {
        
        
        // Create cleaned versions of the data
        let nickname = nickname.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            if  err != nil {
                print(email)
                print(password)
                print(err)
                print("CREATE USER ERROR")
            } else {
                print("KAYIT BAŞARILI")
                // DATABASE
                let firestoreDatabase = Firestore.firestore()
                var firestoreReference : DocumentReference? = nil
                let uuid = UUID().uuidString
                let firestoreUsers =  ["name" : self.nickname.text as Any,
                                       "email" : Auth.auth().currentUser?.email,
                                       "date" : FieldValue.serverTimestamp(),
                                       "uuid": uuid] as [String: Any]
                
                firestoreReference = firestoreDatabase.collection("users").addDocument(data: firestoreUsers, completion: { error in
                    if error != nil {
                        print("NICK VE MAİL KAYIT SORUNLU")
                    } else {
                        print("*** KAYIT BAŞARILI TAMAMI ****")
                    }
                })
            }
            
        }
    }
}
