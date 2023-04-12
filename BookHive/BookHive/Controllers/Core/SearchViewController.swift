//
//  SearchViewController.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 12.04.2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func loadView() {
        let searchView = Bundle.main.loadNibNamed("SearchViewController", owner: self, options: nil)?.first as! UIView
        self.view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        
    }
    
    private func tableViewSetup() {
        tableView.register(SearchTableViewCell.nib(), forCellReuseIdentifier: SearchTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self        
    }


}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as! SearchTableViewCell
//        cell.textLabel?.text = "1984"
//        cell.bookImageView.image = UIImage(named: "12")
        return cell
    }
    
    
}

extension SearchViewController: UITableViewDelegate {
   
}
