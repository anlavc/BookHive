//
//  SearchViewController.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 12.04.2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    override func loadView() {
        let searchView = Bundle.main.loadNibNamed("SearchViewController", owner: self, options: nil)?.first as! UIView
        self.view      = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
    }
    
    // MARK: - Table View Setup
    private func tableViewSetup() {
        tableView.dataSource = self
        tableView.delegate   = self
        tableView.register(SearchTableViewCell.nib(), forCellReuseIdentifier: SearchTableViewCell.identifier)
    }

}
// MARK: - Extensions
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
   
}
