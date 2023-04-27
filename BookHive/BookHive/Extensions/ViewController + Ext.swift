//
//  ViewController + Ext.swift
//  BookHive
//
//  Created by Anıl AVCI on 28.04.2023.
//


import UIKit


extension UIViewController {
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: NSLocalizedString(title, comment: ""), message: NSLocalizedString(message, comment: ""), preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
