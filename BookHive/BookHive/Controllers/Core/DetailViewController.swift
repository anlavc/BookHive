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
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var aboutTextLabel: UILabel!
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
        aboutTextLabel.text = "ABOUT"
        
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
        viewModel.fetchDetailBooks(detail: selectedBook ?? "")
    }
    func setup(book: DetailModel) {
        self.titleLabel.text = book.title ?? ""
        self.aboutLabel.text = book.description ?? ""
        // Download image and set
//        let olid = olidID
//        let cover = coverID ?? 0
      
        imageView.setImageCover(with: viewModel.detailBook?.covers?[0] ?? 0)
            print("---- ** prınt COVER IMAGE ")
        
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
                if self.viewModel.detailBook?.title?.count == 0 {
                    print("DATA COUNT DETAIL ----->>>> 0")
                } else {
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                        self.setup(book: self.viewModel.detailBook!)
                       
                        
                    }
                }
                print("Data loaded count detail...\( self.viewModel.detailBook?.title?.count)")
            case .error(let error):
                print("HATA VAR!!!! \(error?.localizedDescription)")
            }
        }
    }

}
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.detailBook?.subjects?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailSubjectCell.identifier, for: indexPath) as! DetailSubjectCell
        cell.subjectLabel.text = viewModel.detailBook?.subjects![indexPath.row]
      //  cell.setup(book: Work)
        return cell
    }
 
}

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    
}

