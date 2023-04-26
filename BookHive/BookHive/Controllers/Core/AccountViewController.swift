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


    override func viewDidLoad() {
        super.viewDidLoad()
        userInformationForm()
        aboutForm()
        developerInfoForm()
        accountInfoForm()
    }
    
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
                func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
                    controller.dismiss(animated: true, completion: nil)
                    switch result {
                    case .sent:
                        print("sent")
                    case .saved:
                        print("saved")
                    case .failed:
                        print("failed")
                    case .cancelled:
                        print("cancelled")
                    default:
                        break
                    }
                }
                
                // MARK: Helper Functions
                func resultAlert(title: String, message: String, titleForAction: String) {
                    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: titleForAction, style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
                // MARK: Private Functions
                func sendMail() {
                    let mailComposeVC = MFMailComposeViewController()
                    mailComposeVC.mailComposeDelegate = self
                    mailComposeVC.setToRecipients(["bookhive0@gmail.com"])
                    mailComposeVC.setSubject("")
                    mailComposeVC.setMessageBody("", isHTML: false)
                    self.present(mailComposeVC, animated: true)
                }
                
                if !MFMailComposeViewController.canSendMail() {
                    let alert = UIAlertController(title: "Error", message: "Mail services are not available", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    return 
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
    
    private func developerInfoForm() {
        form +++
        Section(NSLocalizedString("Developers", comment: ""))
        <<< AccountCustomRow() {
            $0.cell.accountTableViewCellLabelName.text = "Anıl Avcı"
            $0.cell.accountIconImageView.image = UIImage(named: "devicon")?.withTintColor(.systemGray)
            $0.onCellSelection { cell, row in
                if let url = URL(string: "https://www.linkedin.com/in/anilavci/") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
        
        <<< AccountCustomRow() {
            $0.cell.accountTableViewCellLabelName.text = "Mehdican Büyükplevne"
            $0.cell.accountIconImageView.image = UIImage(named: "devicon")?.withTintColor(.systemGray)
            $0.onCellSelection { cell, row in
                if let url = URL(string: "https://www.linkedin.com/in/mbuyukplevne/") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
    }
    
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
