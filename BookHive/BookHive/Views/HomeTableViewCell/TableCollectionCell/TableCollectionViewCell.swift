//
//  TableCollectionViewCell.swift
//  BookHive
//
//  Created by Anıl AVCI on 12.04.2023.
//

import UIKit

class TableCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TableCollectionViewCell"
    
    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    static func nib() -> UINib {
        return UINib(nibName: "TableCollectionViewCell", bundle: nil)
    }
}
