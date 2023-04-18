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
        let olid = book.availability?.openlibrary_edition
        let cover = String(book.cover_i ?? 0)
        
        if cover == nil {
            imageView.setImageOlid(with: olid!)
        } else {
            imageView.setImageCover(with: Int(cover)!)
        }
    }
    static func nib() -> UINib {
        return UINib(nibName: "TableCollectionViewCell", bundle: nil)
    }
}
