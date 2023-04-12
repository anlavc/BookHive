//
//  HomeTableViewCell.swift
//  BookHive
//
//  Created by Anıl AVCI on 12.04.2023.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
let cell = "TableCollectionViewCell"
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionRegister()
        
        
    }
    private func collectionRegister() {
        collectionView.register(UINib(nibName: cell, bundle: nil), forCellWithReuseIdentifier: cell)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookList[collectionView.tag].bookImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell, for: indexPath) as! TableCollectionViewCell
        cell.imageView.image = UIImage(named: bookList[collectionView.tag].bookImage[indexPath.row])
        cell.bookName.text = bookList[collectionView.tag].bookName[indexPath.row]
        return cell
    }
    
    
}
