//
//  NowCollectionViewCell.swift
//  BookHive
//
//  Created by Anıl AVCI on 25.04.2023.
//
import UIKit

class NowCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "NowCollectionViewCell"
    
    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func setup(book: Work) {
        bookName.text = book.title
        // Download image and set
        if let olid = book.cover_edition_key {
            imageView.setImageOlid(with: olid)
        } else if let cover = book.cover_i, cover != 0 {
            imageView.setImageCover(with: cover)
        } else {
            imageView.image = UIImage(systemName: "book.circle")
        }
    }
    static func nib() -> UINib {
        return UINib(nibName: "NowCollectionViewCell", bundle: nil)
    }
}
