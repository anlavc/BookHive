//
//  SearchViewController.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 12.04.2023.
//

import UIKit
import Kingfisher

class SearchViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView     : UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    var viewModel = SearchViewModel()
    var searchBar: UISearchBar!
    
    // MARK: - Life Cycle
    override func loadView() {
        let searchView = Bundle.main.loadNibNamed("SearchViewController", owner: self, options: nil)?.first as! UIView
        self.view      = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSearchBar()
        collectionViewSetup()
        tableViewSetup()
        observeEvent()
    }
    
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else {return}
            
            switch event {
            case .loading:
                print("Product Loading...")
            case .stopLoading:
                print("Stop Loading...")
            case .dataLoaded:
                if self.viewModel.searchBook.count == 0 {
                    print("Data Count ----> 0")
                } else {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                print("Data Loaded count...\(self.viewModel.searchBook.count)")
            case .error(let error):
                print("Upps,Error \(error?.localizedDescription)")
            }
        }
    }
    
    // MARK: - Collection View Config
     func collectionViewSetup() {
        collectionView.isHidden = false
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(LibraryCollectionViewCell.nib(), forCellWithReuseIdentifier: LibraryCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    
    // MARK: - Create Search Bar
    private func createSearchBar() {
        searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        view.addSubview(searchBar)

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    // MARK: - Table View Config
    private func tableViewSetup() {
        tableView.isHidden   = true
        tableView.dataSource = self
        tableView.delegate   = self
        tableView.register(SearchTableViewCell.nib(), forCellReuseIdentifier: SearchTableViewCell.identifier)
    }

}
// MARK: - Extensions Table View
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchBook.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        cell.searchConfig(model: viewModel.searchBook[indexPath.row])
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

// MARK: - Extensions Collection View
extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LibraryCollectionViewCell.identifier, for: indexPath) as! LibraryCollectionViewCell
        let cellColor = UIColor.cellColors[indexPath.row % UIColor.cellColors.count]
        cell.cellColor = cellColor
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegate {
    
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 158, height: 202)
    }
}

// MARK: - Extensions Search Bar
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.collectionView.isHidden = false
            self.tableView.isHidden = true
        } else {
            self.collectionView.isHidden = true
            self.tableView.isHidden = false
            self.viewModel.fetchSearchBooks(searchWord: searchText)
            self.tableView.reloadData()
        }
    }
}
