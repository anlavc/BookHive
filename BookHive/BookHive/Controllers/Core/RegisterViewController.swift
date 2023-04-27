//
//  RegisterViewController.swift
//  BookHive
//
//  Created by Anıl AVCI on 26.04.2023.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        xibRegister()
    }


    private func xibRegister() {
        Bundle.main.loadNibNamed("RegisterViewController", owner: self, options: nil)![0] as? RegisterViewController
    }

}
