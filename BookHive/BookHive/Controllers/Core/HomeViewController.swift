//
//  HomeViewController.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 12.04.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    let cell = "HomeTableViewCell"
    let cellCoursel = "HomeCourselTableViewCell"
    let circle = "CategoryCircleCell"
    
    let sections = ["BEST_SELLERS","CATEGORY_CHOOSE","TRENDING_BOOKS","BEST_SHARE"]
    
 
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().backgroundColor = UIColor.red
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
        //courcell
        tableView.register(UINib(nibName: cellCoursel, bundle: nil), forCellReuseIdentifier: cellCoursel)
        //trending
        tableView.register(UINib(nibName: cell, bundle: nil), forCellReuseIdentifier: cell)
        // circle
        tableView.register(UINib(nibName: circle, bundle: nil), forCellReuseIdentifier: circle)
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
        switch indexPath.section {
        case 0:
            let cell1 = tableView.dequeueReusableCell(withIdentifier: cellCoursel, for: indexPath) as! HomeCourselTableViewCell
            return cell1
        case 1:
            let cell2 = tableView.dequeueReusableCell(withIdentifier: circle, for: indexPath) as! CategoryCircleCell
            return cell2
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: cell, for: indexPath) as! HomeTableViewCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    //section header config
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //headerview
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        //titlelabel
        let titleLabel = UILabel(frame: CGRect(x: 10, y: 10, width: headerView.frame.size.width, height: 20))
        titleLabel.text = "\(sections[section])"
        titleLabel.font = UIFont.systemFont(ofSize: 20,weight: .bold) // Font boyutunu ayarlayın
        headerView.addSubview(titleLabel)
        //button
     
        return headerView
    }
    //Tableview section header bg color
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if section == 0 {
            let headerView = view as! UIView
            headerView.backgroundColor = UIColor(named: "coverbgColor")
        } else if section == 1 {
            let headerView = view as! UIView
            headerView.isHidden = true
            
           
        }
       
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            return 10
        default:
            return 40
        }
    }
    //Homevc cell height setting
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 220
        case 1:
            return 120
        case 2:
            return 210
        default:
            return 200
        }

    }
    
}

