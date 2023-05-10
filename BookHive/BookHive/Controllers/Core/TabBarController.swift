//
//  TabBarController.swift
//  BookHive
//
//  Created by Anıl AVCI on 27.04.2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
    }

}
