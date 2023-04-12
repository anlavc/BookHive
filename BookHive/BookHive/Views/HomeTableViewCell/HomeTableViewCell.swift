//
//  HomeTableViewCell.swift
//  BookHive
//
//  Created by Anıl AVCI on 12.04.2023.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionSetup()
        
        
    }
    private func collectionSetup() {
        collectionView.register(TableCollectionViewCell.nib(), forCellWithReuseIdentifier: TableCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}
extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookList[collectionView.tag].bookImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TableCollectionViewCell.identifier, for: indexPath) as! TableCollectionViewCell
        cell.imageView.image = UIImage(named: bookList[collectionView.tag].bookImage[indexPath.row])
        cell.bookName.text = bookList[collectionView.tag].bookName[indexPath.row]
        return cell
    }
    
    
}
