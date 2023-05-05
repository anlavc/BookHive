//
//  HomeViewController.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 12.04.2023.
//

import UIKit

class HomeViewController: UIViewController, HomeCourseTableViewCellDelegate {
    
    func didSelectCell(selectedItem: Work) {
        if let coverID = selectedItem.cover_edition_key {
            let vc = DetailViewController()
            vc.selectedBook             = selectedItem.key // choosebookkey
            vc.detailID                 = coverID
            vc.bookTitle                = selectedItem.title // title
            var languageArray           = selectedItem.language?.prefix(2)
            vc.language                 = languageArray?.joined(separator: " & ") ?? "Unknown"
            vc.authorName               = selectedItem.author_name?.joined(separator: " & ") ?? selectedItem.authors?[0].name
            vc.publishDateData          = selectedItem.first_publish_year
            vc.modalPresentationStyle   = .fullScreen
            present(vc, animated: true)
        }
        presentGFAlertOnMainThread(title: "Opss", message: "Sorry, details of the book could not be found!", buttonTitle: "OK")
    }
    //MARK: - Cell Identifier
    let cell            = "HomeTableViewCell"
    let cellCarousel    = "HomeCarouselTableViewCell"
    let nowCell         = "NowTableViewCell"
    let yearly          = "YearlyTableViewCell"
    let viewModel       = HomeViewModel()
    let sections        = ["","NOW_TREND","WEEK_TREND","MOUNTH_TREND"]
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        xibRegister()
        tableRegister()
        setTable()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func xibRegister() {
        Bundle.main.loadNibNamed("HomeViewController", owner: self, options: nil)![0] as? HomeViewController
    }
    private func tableRegister() {
        //courcell
        tableView.register(UINib(nibName: cellCarousel, bundle: nil), forCellReuseIdentifier: cellCarousel)
        //trending
        tableView.register(UINib(nibName: cell, bundle: nil), forCellReuseIdentifier: cell)
        // now
        tableView.register(UINib(nibName: nowCell, bundle: nil), forCellReuseIdentifier: nowCell)
        //yearly
        tableView.register(UINib(nibName: yearly, bundle: nil), forCellReuseIdentifier: yearly)
        
    }
    private func setTable() {
        tableView.dataSource    = self
        tableView.delegate      = self
    }
}
//MARK: - Tableview DataSource Methods
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            // bestsellers
            let cell1 = tableView.dequeueReusableCell(withIdentifier: cellCarousel, for: indexPath) as! HomeCarouselTableViewCell
            cell1.delegate = self
            return cell1
        case 1:
            //now
            let cell = tableView.dequeueReusableCell(withIdentifier: nowCell, for: indexPath) as! NowTableViewCell
            cell.delegate = self
            return cell
        case 2:
            //week
            let cell2 = tableView.dequeueReusableCell(withIdentifier: cell, for: indexPath) as! HomeTableViewCell
            cell2.delegate = self
            return cell2
        case 3:
            let cell3 = tableView.dequeueReusableCell(withIdentifier: yearly, for: indexPath) as! YearlyTableViewCell
            cell3.delegate = self
            return cell3
            
        default:
            return UITableViewCell()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
}
//MARK: - Tableview Delegate Methods
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView  = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let titleLabel  = UILabel(frame: CGRect(x: 10, y: 10, width: headerView.frame.size.width, height: 20))
        titleLabel.text = "\(sections[section])"
        titleLabel.font = UIFont.systemFont(ofSize: 20,weight: .bold) // Font size
        headerView.addSubview(titleLabel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if section == 0 {
            let headerView = view
            headerView.backgroundColor = UIColor(named: "coverbgColor") //Tableview section header bg color
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 220  //Homevc cell height setting
        default:
            return 210
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        }
    }
}
