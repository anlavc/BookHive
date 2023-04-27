//
//  AccountViewController.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 12.04.2023.
//

import UIKit
import Eureka
import MessageUI

class AccountViewController: FormViewController, MFMailComposeViewControllerDelegate {

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        userInformationForm()
        aboutForm()
        developerInfoForm()
        accountInfoForm()
    }
    
    // MARK: - User Information Form
    private func userInformationForm() {
        form +++
        Section(NSLocalizedString("User Informatıon", comment: ""))
        <<< LabelRow() {
            $0.title = NSLocalizedString("Name", comment: "")
            $0.value = "Auth.auth().currentUser?.displayName" // Firebase kurulumdan sonra kullanıcının bilgilerini buraya çekeceğiz
        }
        <<< LabelRow() {
            $0.title = NSLocalizedString("Email", comment: "")
            $0.value = "Auth.auth().currentUser?.email"
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
                //
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
                // logout button tapped
            }
        }
        
        <<< ButtonRow() {
            $0.title = NSLocalizedString("Delete Account", comment: "")
            $0.cellUpdate { cell, row in
                cell.textLabel?.textColor = .systemRed
            }
            $0.onCellSelection { cell, row in
                //
            }
        }
    }
}
