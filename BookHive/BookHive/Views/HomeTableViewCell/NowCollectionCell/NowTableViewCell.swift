//
//  NowTableViewCell.swift
//  BookHive
//
//  Created by Anıl AVCI on 23.04.2023.
//

import UIKit
import Kingfisher

class NowTableViewCell: UITableViewCell {
    private var viewModel = HomeViewModel()
    @IBOutlet weak var collectionView: UICollectionView!
    var delegate : HomeCourseTableViewCellDelegate?
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        initViewModel()
        observeEvent()
        collectionSetup()
    }
    func initViewModel() {
        viewModel.fetchNowTrendBooks()
    }
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else {return}
            switch event {
            case .loading:
                DispatchQueue.main.async {
                    self.indicator.startAnimating()
                }
                print("Product loading...")
            case .stopLoading:
                DispatchQueue.main.async {
                    self.indicator.stopAnimating()
                }
                print("Stop loading...")
            case .dataLoaded:
                if self.viewModel.nowBook.count == 0 {
                    print("DATA COUNT ----->>>> 0")
                } else {
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                        self.indicator.stopAnimating()
                    }
                }
                print("Data loaded count...\( self.viewModel.nowBook.count)")
            case .error(let error):
                print("HATA VAR!!!! \(error?.localizedDescription)")
            }
        }
    }
    private func collectionSetup() {
        collectionView.register(NowCollectionViewCell.nib(), forCellWithReuseIdentifier: NowCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}
extension NowTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.nowBook.count
        //return bookList[collectionView.tag].bookImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NowCollectionViewCell.identifier, for: indexPath) as! NowCollectionViewCell
        cell.setup(book: viewModel.nowBook[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectCell(selectedItem: viewModel.nowBook[indexPath.row])
    }
    
}

