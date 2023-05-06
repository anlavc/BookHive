//
//  ViewController + Ext.swift
//  BookHive
//
//  Created by Anıl AVCI on 28.04.2023.
//


import UIKit


extension UIViewController {
    
    func presentBottomAlert(title: String, message: String, okTitle: String, cancelTitle: String, okAction: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let okAction = UIAlertAction(title: okTitle, style: .default) { _ in
            okAction()
        }
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: .destructive, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }

    func presentGFAlertOnMainThread(title: String,message:String,buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = AlertViewController(title: NSLocalizedString(title, comment: ""), message: NSLocalizedString(message, comment: ""), buttonTitle: NSLocalizedString(buttonTitle, comment: ""))
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC,animated: true)
        }
    }

 }
