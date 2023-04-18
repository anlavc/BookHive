//
//  AccountViewController.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 12.04.2023.
//

import UIKit

class AccountViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileInfoView: UIView!
    @IBOutlet weak var profileFullNameLabel: UILabel!
    @IBOutlet weak var profileEmailLabel: UILabel!
    
    override func loadView() {
        let accountView = Bundle.main.loadNibNamed("AccountViewController", owner: self)?.first as? UIView
        self.view = accountView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfigure()
        profileView.layer.cornerRadius = 20
    }
    
    private func tableViewConfigure() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AccountTableViewCell.nib(), forCellReuseIdentifier: AccountTableViewCell.identifier)
    }

}

extension AccountViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountTableViewCell.identifier, for: indexPath) as! AccountTableViewCell
        return cell
    }
}

extension AccountViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}
