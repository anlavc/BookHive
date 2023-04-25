//
//  AccountViewController.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 12.04.2023.
//

import UIKit

class AccountViewController: UIViewController {
    
    let model = AccountModel()
    
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
        viewsConfig()
        profileView.layer.cornerRadius = 20
    }
    
    private func tableViewConfigure() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AccountTableViewCell.nib(), forCellReuseIdentifier: AccountTableViewCell.identifier)
    }
    
    private func viewsConfig() {
        profileView.addShadow(color: .black, opacity: 0.5, offset: CGSize(width: 5, height: 5), radius: 5)
    }

}

extension AccountViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.accountModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountTableViewCell.identifier, for: indexPath) as! AccountTableViewCell
        cell.accountTableViewCellLabelName.text = model.accountModel[indexPath.row].title
        return cell
    }
}

extension AccountViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
