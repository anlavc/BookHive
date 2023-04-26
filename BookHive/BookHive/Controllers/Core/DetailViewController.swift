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
        
        addReadButton.layer.cornerRadius = 5
        readButton.layer.cornerRadius = 5
        bgview.layer.cornerRadius = 20 // istediğiniz yarıçap değeri
        bgview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.layer.cornerRadius = 5
    }
    private func setUpText() {
       
//        let ratingimage = UIImage(named: imageName)
        
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
        viewModel.fetchRating(olidKey: selectedBook!)
    }
    private func setupOlid(olid: DetailModel2) {
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
    private func setupRatingImage(olidKey: Rating) {
        // image ismini tutacak bir değişken tanımlayalım
          var imageName: String
          
          // olidKey değerine göre imageName değişkenini güncelleyelim
        switch olidKey.summary?.average {
            case 0:
              imageName = "0_star"
            case 0.5:
              imageName = "0-5_star"
            case 1:
              imageName = "1_star"
            // diğer durumlar için de aynı şekilde devam edelim
            case 1.5:
              imageName = "1-5_star"
            case 2:
              imageName = "2_star"
            case 2.5:
              imageName = "2-5_star"
            case 3:
              imageName = "3_star"
            case 3.5:
              imageName = "3-5_star"
            case 4:
              imageName = "4_star"
            case 4.5:
              imageName = "4-5_star"
            case 5:
              imageName = "5_star"
            default:
              // eğer olidKey beklenen değerlerden farklıysa bir hata mesajı gösterelim
              print("Invalid rating value")
              return // fonksiyondan çıkalım
          }
          
          // imageName değişkenini kullanarak image nesnesi oluşturalım
          let image = UIImage(named: imageName)
          
          // image nesnesini istediğiniz şekilde kullanabilirsiniz
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
                    if let detail = self.viewModel.detailOlid {
                        self.setupOlid(olid: detail)
                    }
                 
                    
                    if let starpoint = self.viewModel.rating?.summary?.average {
                        var imageName : String
                        switch starpoint {
                          case 0...0.5: // 0 ile 0.5 arasındaki tüm değerler için
                            imageName = "0-5_star"
                          case 0.5...1: // 0.5 ile 1 arasındaki tüm değerler için
                            imageName = "1_star"
                          case 1...1.5: // 1 ile 1.5 arasındaki tüm değerler için
                            imageName = "1-5_star"
                          case 1.5...2: // 1.5 ile 2 arasındaki tüm değerler için
                            imageName = "2_star"
                          case 2...2.5: // 2 ile 2.5 arasındaki tüm değerler için
                            imageName = "2-5_star"
                          case 2.5...3: // 2.5 ile 3 arasındaki tüm değerler için
                            imageName = "3_star"
                          case 3...3.5: // 3 ile 3.5 arasındaki tüm değerler için
                            imageName = "3-5_star"
                          case 3.5...4: // 3.5 ile 4 arasındaki tüm değerler için
                            imageName = "4_star"
                          case 4...4.5: // 4 ile 4.5 arasındaki tüm değerler için
                            imageName = "4-5_star"
                          case 4.5...5: // 4.5 ile 5 arasındaki tüm değerler için
                            imageName = "5_star"
                        default:
                            imageName = "0_star"
                        }
                        self.ratingImage.image = UIImage(named: imageName)
                    }
                 
                   
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

