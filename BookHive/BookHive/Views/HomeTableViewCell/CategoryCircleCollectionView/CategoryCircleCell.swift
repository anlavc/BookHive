//
//  CategoryCircleCell.swift
//  BookHive
//
//  Created by Anıl AVCI on 16.04.2023.
//

import UIKit

class CategoryCircleCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionSetup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func collectionSetup() {
        collectionView.register(CategoryCircleCollectionCell.nib(), forCellWithReuseIdentifier: CategoryCircleCollectionCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}
extension CategoryCircleCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCircleCollectionCell.identifier, for: indexPath) as! CategoryCircleCollectionCell
      //  cell.setup(book: Work)
        return cell
    }
    
    
}
