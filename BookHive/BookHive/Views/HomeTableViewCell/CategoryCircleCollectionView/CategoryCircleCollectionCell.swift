//
//  CategoryCircleCollectionCell.swift
//  BookHive
//
//  Created by Anıl AVCI on 16.04.2023.
//

import UIKit

class CategoryCircleCollectionCell: UICollectionViewCell {
    static let identifier = "CategoryCircleCollectionCell"
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
     
        imageView.layer.borderWidth = 1.0
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
    }
    func setup(book: Work) {
        
    }
     static func nib() -> UINib {
         return UINib(nibName: "CategoryCircleCollectionCell", bundle: nil)
     }
}
