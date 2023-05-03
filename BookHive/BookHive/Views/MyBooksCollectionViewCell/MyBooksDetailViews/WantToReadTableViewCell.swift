//
//  WantToReadTableViewCell.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 3.05.2023.
//

import UIKit

class WantToReadTableViewCell: UITableViewCell {
    
    static let identifier = "WantToReadTableViewCell"
    
    @IBOutlet weak var imageBackView: UIView!
    @IBOutlet weak var readView: UIView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        bookImageView.addShadow(color: .gray, opacity: 0.5, offset: CGSize(width: 2, height: 2), radius: 5)
        readView.addShadow(color: .gray, opacity: 0.5, offset: CGSize(width: 2, height: 2), radius: 5)


    }
    
    static func nib() -> UINib {
        return UINib(nibName: "WantToReadTableViewCell", bundle: nil)
    }
    
    public func configure(book: Book) {
        bookImageView.setImageOlid(with: book.coverID ?? "")
        bookNameLabel.text = book.title
        authorNameLabel.text = book.author
    }
    
}
