//
//  HomeViewController.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 12.04.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    let cell = "HomeTableViewCell"
    //private var viewModel = HomeViewModel()
 
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        xibRegister()
        tableRegister()
        // Right Bar Button Item
            let rightButton = UIBarButtonItem(title: "Button Title", style: .plain, target: self, action: #selector(rightButtonTapped))
            navigationItem.rightBarButtonItem = rightButton
     
        
    }
    private func xibRegister() {
        Bundle.main.loadNibNamed("HomeViewController", owner: self, options: nil)![0] as? HomeViewController
    }
    private func tableRegister() {
        tableView.register(UINib(nibName: cell, bundle: nil), forCellReuseIdentifier: cell)
        tableView.dataSource = self
        tableView.delegate = self
    }
    @objc func rightButtonTapped() {
        print("tapped all")
        
    }


}
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell, for: indexPath) as! HomeTableViewCell
        cell.collectionView.tag = indexPath.section
        cell.collectionView.reloadData()
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return bookList.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //headerview
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        //titlelabel
        let titleLabel = UILabel(frame: CGRect(x: 10, y: 10, width: headerView.frame.size.width, height: 20))
        titleLabel.text = "\(bookList[section].sectionType)"
        titleLabel.font = UIFont.systemFont(ofSize: 20,weight: .bold) // Font boyutunu ayarlayın
        headerView.addSubview(titleLabel)
        //button
     
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

