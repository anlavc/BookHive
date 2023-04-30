//
//  ReadListCollectionViewCell.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 30.04.2023.
//

import UIKit

class ReadListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ReadListCollectionViewCell"
    
    @IBOutlet weak var bookView: UIView!
    @IBOutlet weak var bookNameView: UIView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ReadListCollectionViewCell", bundle: nil)
    }

}
