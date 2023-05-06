//
//  AccountViewController.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 12.04.2023.
//

import UIKit
import Eureka
import MessageUI
import FirebaseAuth
import Firebase

class AccountViewController: FormViewController, MFMailComposeViewControllerDelegate {
    var nickname: String? {
        didSet {
            userInformationForm()
            aboutForm()
            developerInfoForm()
            accountInfoForm()
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchName()
    }
    
    // MARK: - User Information Form
    private func userInformationForm() {
        form +++
        Section(NSLocalizedString("User Informatıon", comment: ""))
        <<< LabelRow() {
            $0.title = NSLocalizedString("Name", comment: "")
            $0.value = nickname
        }
        <<< LabelRow() {
            $0.title = NSLocalizedString("Email", comment: "")
            $0.value = Auth.auth().currentUser?.email
        }
    }
    func fetchName() {
        guard let currentUser = Auth.auth().currentUser else { return }
        let uid = currentUser.uid
        
        Firestore.firestore().collection("users").document(uid).getDocument { (document, error) in
            if let document = document, document.exists {
                let name = document.get("name") as? String ?? ""
                self.nickname = name
            } else {
                self.nickname = ""
            }
        }
    }
    
    // MARK: - About Form
    private func aboutForm() {
        form +++
        Section(NSLocalizedString("About", comment: ""))
        <<< AccountCustomRow() {
            $0.cell.accountTableViewCellLabelName.text = NSLocalizedString("About", comment: "")
            $0.cell.accountIconImageView.image = UIImage(systemName: "info.circle")
            $0.onCellSelection { cell, row in
                let vc = AboutViewController()
                vc.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(self.backButtonAction))
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
        }
        
        <<< AccountCustomRow() {
            $0.cell.accountTableViewCellLabelName.text = NSLocalizedString("Contact", comment: "")
            $0.cell.accountIconImageView.image = UIImage(systemName: "captions.bubble")
            $0.onCellSelection { cell, row in
                let alertController = UIAlertController(title: NSLocalizedString("Support", comment: ""), message: nil, preferredStyle: .actionSheet)
                let sendEmailAction = UIAlertAction(title: NSLocalizedString("Send Email", comment: ""), style: .default) { action in
                    self.sendEmail()
                }
                alertController.addAction(sendEmailAction)
                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
        <<< AccountCustomRow() {
            $0.cell.accountTableViewCellLabelName.text = NSLocalizedString("Share Us", comment: "")
            $0.cell.accountIconImageView.image = UIImage(systemName: "square.and.arrow.up")
            $0.onCellSelection { cell, row in
                if let link = URL(string: "https://www.apple.com") {
                    let shareItems: [Any] = [link]
                    let activityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
                    self.present(activityViewController, animated: true, completion: nil)
                }
            }
        }
        
        
        <<< AccountCustomRow() {
            $0.cell.accountTableViewCellLabelName.text = NSLocalizedString("Rate us in App Store", comment: "")
            $0.cell.accountIconImageView.image = UIImage(systemName: "star.leadinghalf.filled")
            $0.onCellSelection { cell, row in
                // App Store URL
                //                if let url = URL(string: "") {
                //                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                //                }
            }
        }
    }
    
    @objc func backButtonAction() {
        let vc = AboutViewController()
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Mail Compose Funcs.
    private func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mailComposeViewController = MFMailComposeViewController()
            mailComposeViewController.mailComposeDelegate = self
            mailComposeViewController.setToRecipients(["bookhive0@gmail.com"])
            mailComposeViewController.setSubject(NSLocalizedString("Feedback", comment: ""))
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: NSLocalizedString("Cannot Send Email", comment: ""), message: NSLocalizedString("Your device cannot send email. Please configure an email account in the Mail app and try again", comment: ""), preferredStyle: .alert)
            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Developers Form
    private func developerInfoForm() {
        form +++
        Section(NSLocalizedString("Developers", comment: ""))
        <<< AccountCustomRow() {
            $0.cell.accountTableViewCellLabelName.text = "Anıl Avcı"
            $0.cell.accountIconImageView.image = UIImage(named: "developer")?.withTintColor(.systemGray)
            $0.onCellSelection { cell, row in
                if let url = URL(string: "https://www.linkedin.com/in/anilavci/") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
        
        <<< AccountCustomRow() {
            $0.cell.accountTableViewCellLabelName.text = "Mehdican Büyükplevne"
            $0.cell.accountIconImageView.image = UIImage(named: "developer")?.withTintColor(.systemGray)
            $0.onCellSelection { cell, row in
                if let url = URL(string: "https://www.linkedin.com/in/mbuyukplevne/") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
    }
    
    // MARK: - Account Information Form
    private func accountInfoForm() {
        form +++
        Section("")
        form +++
        Section("")
        <<< ButtonRow() {
            $0.title = NSLocalizedString("Logout", comment: "")
            $0.cellUpdate { cell, row in
                cell.textLabel?.textColor = .darkGray
            }
            $0.onCellSelection { cell, row in
                do {
                    try Auth.auth().signOut()
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let tabBar = storyboard.instantiateViewController(identifier: "navBar") as? UINavigationController
                    self.view.window?.rootViewController = tabBar
                    self.view.window?.makeKeyAndVisible()
                } catch {
                    print("çıkış hatası")
                }
            }
        }
        
        <<< ButtonRow() {
            $0.title = NSLocalizedString("Delete Account", comment: "")
            $0.cellUpdate { cell, row in
                cell.textLabel?.textColor = .systemRed
            }
            $0.onCellSelection { cell, row in
                if let user = Auth.auth().currentUser {
                    let alert = UIAlertController(title: NSLocalizedString("Permanently Delete Account", comment: ""), message: NSLocalizedString("You are permanently deleting your account! This action is irreversible! Are You Sure?", comment: ""), preferredStyle: .alert)
                    let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .destructive) { (_) in
                        
                        guard let user = Auth.auth().currentUser else {
                            self.presentGFAlertOnMainThread(title: "ERROR", message: "No user is currently logged in.", buttonTitle: "OKEY")
                            return
                        }
                        user.delete { error in
                            if let error = error {
                                self.presentGFAlertOnMainThread(title: "ERROR", message: "An error occurred while deleting user account: \(error.localizedDescription)", buttonTitle: "OK")
                            } else {
                                let uid = user.uid
                                Firestore.firestore().collection("users").document(uid).delete { error in
                                    if error != nil {
                                        self.presentGFAlertOnMainThread(title: "ERROR", message: "An error occurred while deleting user data.", buttonTitle: "OK")
                                    } else {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                            let tabBar = storyboard.instantiateViewController(identifier: "navBar") as? UINavigationController
                                            self.view.window?.rootViewController = tabBar
                                            self.view.window?.makeKeyAndVisible()
                                        }
                                    }
                                }
                            }
                        }
                    }
                    let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { (_) in
                        alert.dismiss(animated: true, completion: nil)
                    }
                    alert.addAction(okAction)
                    alert.addAction(cancelAction)
                    self.present(alert, animated: true, completion: nil)
                } else {
//                    print("User is not logged in")
                }
            }
        }
        
        <<< ButtonRow() {
            $0.title = NSLocalizedString("Privacy Policy", comment: "")
            $0.cellSetup { cell, row in
                cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            }
            $0.cellUpdate { cell, row in
                cell.textLabel?.textColor = .systemBlue
            }
            $0.onCellSelection { cell, row in
                if let url = URL(string: "https://www.google.com") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
    }
}
