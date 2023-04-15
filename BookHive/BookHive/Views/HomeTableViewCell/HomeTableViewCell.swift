//
//  HomeTableViewCell.swift
//  BookHive
//
//  Created by Anıl AVCI on 12.04.2023.
//

import UIKit
import Kingfisher

class HomeTableViewCell: UITableViewCell {
    private var viewModel = HomeViewModel()
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    
        initViewModel()
        observeEvent()
        collectionSetup()
    }
    func initViewModel() {
        viewModel.fetchTrendBooks()
    }
    func observeEvent() {
        print("DENEME")
        viewModel.eventHandler = { [weak self] event in
            guard let self else {return}
            
            switch event {
            case .loading:
                //indicator show
                print("Product loading...")
            case .stopLoading:
                // indicator hide
                print("Stop loading...")
            case .dataLoaded:
                if self.viewModel.trendBook.count == 0 {
                    print("DATA COUNT ----->>>> 0")
                } else {
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
                print("Data loaded count...\( self.viewModel.trendBook.count)")
            case .error(let error):
                print("HATA VAR!!!! \(error?.localizedDescription)")
            }
        }
    }
    private func collectionSetup() {
        collectionView.register(TableCollectionViewCell.nib(), forCellWithReuseIdentifier: TableCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}
extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.trendBook.count
        //return bookList[collectionView.tag].bookImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TableCollectionViewCell.identifier, for: indexPath) as! TableCollectionViewCell
        cell.bookName.text = viewModel.trendBook[indexPath.row].title // TİTLE
        // Download image and set
        let olid = viewModel.trendBook[indexPath.item].availability?.openlibrary_edition
        let cover = String(viewModel.trendBook[indexPath.row].cover_i ?? 0)
        if olid == nil {
            cell.imageView.setImageCover(with: Int(cover)!)
            print("------> COVER Indexpath-- \(indexPath.row)")
        } else {
            cell.imageView.setImageOlid(with: olid!)
            print("------> OLİD Indexpath-- \(indexPath.row)")
        }
        return cell
    }
}

// Kingfisher image cache Extensions
extension UIImageView {
    func setImageOlid(with olid: String) {
        let urlString = "https://covers.openlibrary.org/b/olid/\(olid)-M.jpg"
        guard let url = URL(string: urlString) else {
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        print("------> OLİD URL SERVİS \(urlString)")
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
    
    func setImageCover(with cover: Int) {
        let urlString = "https://covers.openlibrary.org/b/id/\(cover)-M.jpg"
        guard let url = URL(string: urlString) else {
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        print("------> COVER URL servis-- \(urlString)")
      
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }

}
