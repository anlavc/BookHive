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
    func setup(book: Work) {
        bookName.text = book.title
        // Download image and set
        let olid = book.cover_edition_key
        let cover = String(book.cover_i ?? 0)
        
        if olid == nil {
            imageView.setImageCover(with: Int(cover)!)

        } else {
            imageView.setImageOlid(with: olid!)
        }
    }
    static func nib() -> UINib {
        return UINib(nibName: "TableCollectionViewCell", bundle: nil)
    }
}
