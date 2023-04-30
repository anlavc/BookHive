//
//  SearchViewController.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 12.04.2023.
//

import UIKit
import Kingfisher
import Lottie

class SearchViewController: UIViewController, SearchTableViewCellDelegate {
    func didSelect(selectedItem: SearchDoc) {
        let vc = DetailViewController()
        vc.selectedBook = selectedItem.key
        vc.detailID = selectedItem.cover_edition_key ?? selectedItem.edition_key![0]
        vc.bookTitle = selectedItem.title
        var languageArray = selectedItem.language?.prefix(2)
        vc.language = languageArray?.joined(separator: "&") ?? "?"
        vc.authorName = selectedItem.author_name?.joined(separator: ",")
        vc.publishDateData = selectedItem.first_publish_year
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    // MARK: - Outlets
    @IBOutlet weak var tableView     : UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var animationGif: AnimatedImageView!
    @IBOutlet weak var findLabel: UILabel!
    
    // MARK: - Properties
    var viewModel = SearchViewModel()
    var button = UIButton(type: .custom)
    var delegate: SearchTableViewCellDelegate?
    
    // MARK: - Life Cycle
    override func loadView() {
        let searchView = Bundle.main.loadNibNamed("SearchViewController", owner: self, options: nil)?.first as! UIView
        self.view      = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldSetup()
        tableViewSetup()
        observeEvent()
        gestureRecognizer()
        startAnimation()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
        }
    }
    //MARK: - Lottie Search Animation Func
    private func startAnimation() {
        let aniView = LottieAnimationView(name: "searchjson")
        aniView.contentMode = .scaleAspectFit
        aniView.loopMode = .loop
        aniView.center = self.animationGif.center
        aniView.frame = self.animationGif.bounds
        aniView.play()
        self.animationGif.addSubview(aniView)
        
    }
    // MARK: - Observe Event
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else {return}
            
            switch event {
            case .loading:
                print("Product Loading...")
            case .stopLoading:
                DispatchQueue.main.async {
                    self.indicator.stopAnimating()
                }
                print("Stop Loading...")
            case .dataLoaded:
                if self.viewModel.searchBook.count == 0 {
                    print("Data Count ----> 0")
                } else {
                    DispatchQueue.main.async {
                        self.indicator.stopAnimating()
                        self.tableView.reloadData()
                    }
                }
                print("Data Loaded count...\(self.viewModel.searchBook.count)")
            case .error(let error):
                print("Upps,Error \(error?.localizedDescription)")
            }
        }
    }
    
    // MARK: - TextField Setup Func.
    private func textFieldSetup() {
        searchTextField.delegate = self
        searchTextField.returnKeyType = .go
        searchTextField.layer.shadowColor = UIColor.systemIndigo.cgColor
        searchTextField.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        searchTextField.layer.masksToBounds = false
        searchTextField.layer.shadowRadius = 1.0
        searchTextField.layer.shadowOpacity = 0.5
        searchTextField.layer.cornerRadius = 10
        button.isHidden = true
        button.tintColor = .label
        button.setImage(UIImage(systemName: "x.circle"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        searchTextField.rightView = button
        searchTextField.rightViewMode = .always
        button.addTarget(self, action: #selector(clearTextField), for: .touchUpInside)
        button.addTarget(self, action: #selector(dismissKeyboard), for: .touchUpInside)
    }
    
    private func gestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Clear TextField Button Action
    @objc func clearTextField() {
        searchTextField.text = ""
        tableView.isHidden = true
        button.isHidden = true
        animationGif.isHidden = false
        findLabel.isHidden = false
        viewModel.searchBook = []
        tableView.reloadData()
    }
    
    // MARK: - Table View Config
    private func tableViewSetup() {
        tableView.isHidden   = true
        tableView.dataSource = self
        tableView.delegate   = self
        tableView.register(SearchTableViewCell.nib(), forCellReuseIdentifier: SearchTableViewCell.identifier)
    }
}

// MARK: - Extensions TextField
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let searchBookWord = searchTextField.turkishText(),
           !searchBookWord.isEmpty {
            button.isHidden = false
            tableView.isHidden = false
            animationGif.isHidden = true
            animationGif.stopAnimating()
            findLabel.isHidden = true
            DispatchQueue.main.async {
                self.viewModel.fetchSearchBooks(searchWord: searchBookWord)
                print("**\(searchBookWord)")
                self.indicator.startAnimating()
                self.tableView.reloadData()
                self.view.endEditing(true)
            }
        }
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if searchTextField.text == "" {
            tableView.isHidden = true
            viewModel.searchBook = []
            tableView.reloadData()
        }
    }
}

// MARK: - Extensions Table View
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchBook.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        cell.delegate = self
        cell.searchConfig(model: viewModel.searchBook[indexPath.row])
        cell.index = viewModel.searchBook[indexPath.row]
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
