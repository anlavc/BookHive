//
//  DetailViewController.swift
//  BookHive
//
//  Created by Anıl AVCI on 19.04.2023.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class DetailViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var dismissButton    : UIButton!
    @IBOutlet weak var collectionView   : UICollectionView!
    @IBOutlet weak var addReadButton    : UIButton!
    @IBOutlet weak var readButton       : UIButton!
    @IBOutlet weak var languageLabelText: UILabel!
    @IBOutlet weak var languageLabel    : UILabel!
    @IBOutlet weak var numberOfPagesLabel: UILabel!
    @IBOutlet weak var pageNumber       : UILabel!
    @IBOutlet weak var publishDateText  : UILabel!
    @IBOutlet weak var publishDate      : UILabel!
    @IBOutlet weak var ratingImage      : UIImageView!
    @IBOutlet weak var ratingLabel      : UILabel!
    @IBOutlet weak var author           : UILabel!
    @IBOutlet weak var titleLabel       : UILabel!
    @IBOutlet weak var imageView        : UIImageView!
    @IBOutlet weak var bgview           : UIView!
    
    //MARK: - Variables
    var selectedBook    : String?
    var detailID        : String!
    var bookTitle       : String?
    var language        : String?
    var authorName      : String?
    var publishDateData : Int?
    var bookDocumentID  : String?
    var favoriteBooks   : [Book] = []
    var readingBooks    : [ReadBook] = []
    
    private var viewModel = DetailViewModel()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        xibRegister()
        setupUI()
        initViewModel()
        observeEvent()
        collectionSetup()
    }
    override func viewWillAppear(_ animated: Bool) {
        favouriteBooksFetch()
        readingBooksFetch()
    }
    
    //MARK: -   A request is sent from Firebase to access the information of favourite books
    func favouriteBooksFetch() {
        if let uuid = Auth.auth().currentUser?.uid {
            let favoriteBooksCollection = Firestore.firestore().collection("users/\(uuid)/favoriteBooks")
            favoriteBooksCollection.getDocuments() { (querySnapshot, error) in
                //Firebase erişimde bir hata var mı kontrol edilir.
                if let error = error {
                    print("Error fetching favorite books: \(error.localizedDescription)")
                    return
                }
                guard let documents = querySnapshot?.documents else {
                    self.presentGFAlertOnMainThread(title: "ERROR", message: "No favorite books found.", buttonTitle: "OKEY")
                    return
                }
                for document in documents {
                    let coverID = document.data()["coverID"] as! String
                    let title   = document.data()["title"] as! String
                    let author  = document.data()["author"] as? String
                    let book    = Book(coverID: coverID, title: title,author: author)
                    
                    self.favoriteBooks.append(book) //firebaseden gelen verilen oluşturulan favoriteBooks dizinin içine append edilir.
                    
                    // Gelen favori kitapların içinde detayına gidilen kitaba ait coverId varsa bu zaten favoride olan bir kitap olduğundan sayfa açıldığında butonda Favorilerde ekli yazar.
                    if coverID == self.detailID {
                        self.addReadButton.setTitle("Added in favorites", for: .normal)
                        self.addReadButton.backgroundColor = UIColor(named: "addedFavoriteButton")
                    }
                }
            }
        }
    }
    
    //MARK: -  A request is sent from Firebase to access the information of reading books
    private func readingBooksFetch() {
        if let uuid = Auth.auth().currentUser?.uid {
            let favoriteBooksCollection = Firestore.firestore().collection("users/\(uuid)/ReadsBooks") //Readbooks collectionu içinde arama yapılır.
            favoriteBooksCollection.getDocuments() { (querySnapshot, error) in
                if let error = error {
                    print("Error fetching favorite books: \(error.localizedDescription)")
                    return
                }
                guard let documents = querySnapshot?.documents else {
                    self.presentGFAlertOnMainThread(title: "ERROR", message: "No read books found.", buttonTitle: "OKEY")
                    return
                }
                for document in documents {
                    let documentID      = document.documentID
                    let coverID         = document.data()["coverID"] as! String
                    let title           = document.data()["title"] as! String
                    let finish          = document.data()["finish"] as! Bool
                    let readPage        = document.data()["readPage"] as! Int
                    let readingDate     = document.data()["readingdate"] as? Date
                    let author          = document.data()["author"] as? String
                    let totalpageNumber = document.data()["totalpageNumber"] as! Int
                    
                    let readbookArray   = ReadBook(coverID: coverID, title: title, finish: finish, readPage: readPage, readingDate: readingDate, totalpageNumber: totalpageNumber, author: author,documentID:documentID)
                    self.readingBooks.append(readbookArray)
                    
                    //  Gelen okunan kitapların içinde detayına gidilen kitaba ait coverId varsa bu zaten okunan  bir kitap olduğundan sayfa açıldığında butonda okunuyor yazar.
                    if coverID == self.detailID {
                        if finish {
                            self.readButton.setTitle(NSLocalizedString("Okundu", comment: ""), for: .normal)
                            self.readButton.backgroundColor = UIColor.brown
                        } else {
                            self.readButton.setTitle("Okunuyor", for: .normal)
                            self.readButton.backgroundColor = UIColor(named: "addedFavoriteButton")
                        }
                    }
                    
                }
            }
        }
    }
    
    @IBAction func dismissButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    //MARK: - Register View Xib
    private func xibRegister() {
        Bundle.main.loadNibNamed("DetailViewController", owner: self, options: nil)![0] as? DetailViewController
    }
    
    //MARK: - UI Configurations
    private func setupUI() {
        addReadButton.layer.cornerRadius    = 5
        readButton.layer.cornerRadius       = 5
        bgview.layer.cornerRadius           = 20
        bgview.layer.maskedCorners          = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.layer.cornerRadius        = 5
    }
    
    //MARK: - Collectionview Setup
    private func collectionSetup() {
        collectionView.register(DetailSubjectCell.nib(), forCellWithReuseIdentifier: DetailSubjectCell.identifier)
        collectionView.dataSource           = self
        if let flowLayout                   = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize    = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    //MARK: - ViewModel fetch data
    private func initViewModel() {
        viewModel.fetchDetailOlid(olidKey: detailID)
        viewModel.fetchRating(olidKey: selectedBook!)
        viewModel.fetchDetailBooks(detail: detailID)
    }
    
    //MARK: - UI variables set
    private func setupOlid(olid: DetailModel2) {
        let pagenumber          = String("\(olid.numberOfPages ?? 0)")
        self.titleLabel.text    = bookTitle
        self.author.text        = authorName
        self.pageNumber.text    = pagenumber
        self.publishDate.text   = String("\(publishDateData ?? 0)")
        self.languageLabel.text = language?.uppercased()
        //image
        let olid = detailID
        imageView.setImageOlid(with: olid!)
    }
    //MARK: - Observed Event
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
                        case 0...0.5:
                            imageName = "0-5_star"
                        case 0.5...1:
                            imageName = "1_star"
                        case 1...1.5:
                            imageName = "1-5_star"
                        case 1.5...2:
                            imageName = "2_star"
                        case 2...2.5:
                            imageName = "2-5_star"
                        case 2.5...3:
                            imageName = "3_star"
                        case 3...3.5:
                            imageName = "3-5_star"
                        case 3.5...4:
                            imageName = "4_star"
                        case 4...4.5:
                            imageName = "4-5_star"
                        case 4.5...5:
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
    //MARK: - ReadButton Tapped
    @IBAction func readButtonTapped(_ sender: Any) {
        readBooksAddorRemove()
    }
    //MARK: - AddtoReadList Button Tapped
    @IBAction func addtoReadListTapped(_ sender: UIButton) {
        favouriteBooksAddorRemove()
    }
    
    //MARK: - Add Favourite and Remove Favourite
    func favouriteBooksAddorRemove() {
        if let uuid = Auth.auth().currentUser?.uid {
            let favoriteBooksCollection = Firestore.firestore().collection("users/\(uuid)/favoriteBooks")
            favoriteBooksCollection.whereField("coverID", isEqualTo: detailID!).getDocuments { (snapshot, error) in // Favori kitaplar içinde coverID göre ilgili kitabın coverid arasında arama yapılır.
                if let error = error {
                    self.presentGFAlertOnMainThread(title: "ERROR", message: "Error adding a book to favorites.", buttonTitle: "OKEY")
                } else {
                    // Favorilerde ekliyle eğer fetch kısmında zaten favorilerde ekli olduğu gözüktüğünde ve coverID ile detail id eşletiği için ilk şart çalışır ve ilgili kitabı favorilerden silerek butronda tekrar favorilere ekle yazar.
                    if let documents = snapshot?.documents {
                        for document in documents {
                            let bookID = document.documentID
                            favoriteBooksCollection.document(bookID).delete()
                            self.addReadButton.setTitle("Add to favorites", for: .normal)
                            self.addReadButton.backgroundColor = UIColor(named: "coverbgColor")
                            
                        }
                        // favoriler arasında coverID bulunamazsa favorilerde ekli değil demektir ve ilgili kitabı favorilere ekleyerek butonda favorilere eklendi yazar.
                        if documents.isEmpty {
                            favoriteBooksCollection.addDocument(data: ["coverID": self.detailID!,
                                                                       "title"  : self.bookTitle!,
                                                                       "author" : self.authorName])
                            self.addReadButton.setTitle("Added in favorites", for: .normal)
                            self.addReadButton.backgroundColor = UIColor(named: "addedFavoriteButton")
                        }
                        DispatchQueue.main.async {
                            self.favouriteBooksFetch() // yeni veri eklendiğinden veya silindiğinden güncel bilgileri tekrar almak için tekrar istek yapılır.
                        }
                    }
                }
            }
        }
    }
    func readBooksAddorRemove() {
        if let uuid = Auth.auth().currentUser?.uid {
            let favoriteBooksCollection = Firestore.firestore().collection("users/\(uuid)/ReadsBooks")
            favoriteBooksCollection.whereField("coverID", isEqualTo: detailID!).getDocuments { (snapshot, error) in
                if let error = error {
                    self.presentGFAlertOnMainThread(title: "ERROR", message: "Error adding the book to the reading list.", buttonTitle: "OKEY")
                } else {
                    // okunuyorsa zaten okunanlardan siler.
                    if let documents = snapshot?.documents {
                        for document in documents {
                            let bookID = document.documentID
                            favoriteBooksCollection.document(bookID).delete()
                            self.readButton.setTitle("Oku", for: .normal)
                            self.readButton.backgroundColor = UIColor(named: "colordarkgray")
                            
                        }
                        // okunmuyorsa kitabı readBooksa ekler.
                        if documents.isEmpty {
                            // Toplam sayfa numarası 0 olup olmadığı kontrol edilir. Eğer sıfırsa else bloğuna gider ve kullanıdan bir totalpage numarası ister.Zaten varsa kitabı okunan kitaplara ekler.
                            if let numberOfPages = self.viewModel.detailOlid?.numberOfPages, numberOfPages != 0 {
                                favoriteBooksCollection.addDocument(data: ["coverID"        : self.detailID!,
                                                                           "title"          : self.bookTitle!,
                                                                           "readPage"       : 0,
                                                                           "author"         : self.authorName,
                                                                           "readingdate"    : FieldValue.serverTimestamp(),
                                                                           "totalpageNumber": numberOfPages,
                                                                           "finish"         : false])
                                self.readButton.setTitle("Okunuyor", for: .normal)
                                self.readButton.backgroundColor = UIColor(named: "addedFavoriteButton")
                            } else {
                                // Totalpage numarası istenir.
                                let alert = UIAlertController(title: "Number of pages not available", message: "Please enter the number of pages", preferredStyle: .alert)
                                alert.addTextField { (textField) in
                                    textField.placeholder = "Number of pages"
                                    textField.keyboardType = .numberPad
                                }
                                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
                                let saveAction = UIAlertAction(title: NSLocalizedString("Save", comment: ""), style: .default) { (action) in
                                    if let textFields = alert.textFields, let text = textFields[0].text, let numberOfPages = Int(text), numberOfPages != 0 {
                                        // Kullanıcının girdiği sayı 0 değil, kaydedilebilir.
                                favoriteBooksCollection.addDocument(data: ["coverID"         : self.detailID!,
                                                                           "title"           : self.bookTitle!,
                                                                           "readPage"        : 0,
                                                                           "author"          : self.authorName,
                                                                           "readingdate"     : FieldValue.serverTimestamp(),
                                                                           "totalpageNumber" : numberOfPages,
                                                                           "finish"          : false])
                                        self.readButton.setTitle("Okunuyor", for: .normal)
                                        self.readButton.backgroundColor = UIColor(named: "addedFavoriteButton")
                                    }
                                }
                                alert.addAction(saveAction)
                                alert.addAction(cancelAction)
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                        DispatchQueue.main.async {
                            self.readingBooksFetch()
                        }
                    }
                }
            }
        }
    }
}

//MARK: - CollectionviewDataSource
extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItems           = viewModel.detailBook?.subjects?.count
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
