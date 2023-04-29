//
//  ReadListViewController.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 29.04.2023.
//

import UIKit

class ReadListViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()

    }
    
    
    private func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ReadtoListTableViewCell.nib(), forCellReuseIdentifier: ReadtoListTableViewCell.identifier)
    }

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
}


extension ReadListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReadtoListTableViewCell.identifier, for: indexPath) as! ReadtoListTableViewCell
        return cell
    }
}

extension ReadListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc =  PageNumberViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 1.0, animations: { cell.alpha = 1 })
    }
}
