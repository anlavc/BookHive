//
//  DetailViewController.swift
//  BookHive
//
//  Created by Anıl AVCI on 19.04.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addReadButton: UIButton!
    @IBOutlet weak var readButton: UIButton!
    @IBOutlet weak var languageLabelText: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var numberOfPagesLabel: UILabel!
    @IBOutlet weak var pageNumber: UILabel!
    @IBOutlet weak var publishDateText: UILabel!
    @IBOutlet weak var publishDate: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bgview: UIView!
    
    var selectedBook: String?
    var detailID: String!
    var bookTitle: String?
    var language: String?
    var authorName: String?
    var publishDateData: Int?
    
    
    private var viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        xibRegister()
        setupUI()
        initViewModel()
        observeEvent()
        collectionSetup()
        setUpText()
       
    }
    @IBAction func dismissButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    private func xibRegister() {
        Bundle.main.loadNibNamed("DetailViewController", owner: self, options: nil)![0] as? DetailViewController
    }
    private func setupUI() {
        addReadButton.layer.borderWidth = 1
        addReadButton.layer.borderColor = UIColor.systemIndigo.cgColor
        addReadButton.layer.cornerRadius = 5
        readButton.layer.cornerRadius = 5
        bgview.layer.cornerRadius = 20 // istediğiniz yarıçap değeri
        bgview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.layer.cornerRadius = 5
    }
    private func setUpText() {
        ratingLabel.text = "RATING"
        let imageName = "rating4.5"
        let ratingimage = UIImage(named: imageName)
        ratingImage.image = ratingimage
        publishDateText.text = "PUBLISH_DATE"
        numberOfPagesLabel.text = "NUMBER_OF_PAGES"
        languageLabelText.text = "LANGUAGES"
        readButton.titleLabel?.text = "READ"
        addReadButton.titleLabel?.text = "ADD_TO_READ_LIST"
        
    }
    private func collectionSetup() {
        collectionView.register(DetailSubjectCell.nib(), forCellWithReuseIdentifier: DetailSubjectCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
              flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            }
    }
    private func initViewModel() {
        viewModel.fetchDetailOlid(olidKey: detailID)
        viewModel.fetchDetailBooks(detail: selectedBook ?? "")
    }
    func setupOlid(olid: DetailModel2) {
        let pagenumber = String("\(olid.numberOfPages ?? 0)")
        self.titleLabel.text = bookTitle
        self.author.text = authorName
        self.pageNumber.text = pagenumber
        self.publishDate.text = String("\(publishDateData ?? 0)")
        self.languageLabel.text = language?.uppercased()
        //image
        let olid = detailID
        imageView.setImageOlid(with: olid!)
    }
   private func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else {return}
            
            switch event {
            case .loading:
                //indicator show
                print("Product loading detail...")
            case .stopLoading:
                // indicator hide
                print("Stop loading detail...")
            case .dataLoaded:
               
                    
                    DispatchQueue.main.async { [self] in
                        self.collectionView.reloadData()
                      
                          self.setupOlid(olid: self.viewModel.detailOlid!)
                     
                    }
               
            case .error(let error):
                print("HATA VAR!!!! \(error?.localizedDescription)")
            }
        }
    }

}
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItems = viewModel.detailBook?.subjects?.count
           if numberOfItems == nil {
               collectionView.isHidden = true
           } else {
               collectionView.isHidden = false
           }
        return numberOfItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailSubjectCell.identifier, for: indexPath) as! DetailSubjectCell
        cell.subjectLabel.text = viewModel.detailBook?.subjects![indexPath.row]
        return cell
    }
 
}

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    
}

