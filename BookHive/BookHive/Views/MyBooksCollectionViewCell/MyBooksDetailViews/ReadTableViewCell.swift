//
//  ReadTableViewCell.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 3.05.2023.
//

import UIKit

class ReadTableViewCell: UITableViewCell {
    
    static let identifier = "ReadTableViewCell"
    
    @IBOutlet weak var readView: UIView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        readView.addShadow(color: .gray, opacity: 0.5, offset: CGSize(width: 2, height: 2), radius: 5)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ReadTableViewCell", bundle: nil)
    }
    
    public func configure(book: ReadBook) {
        bookImageView.setImageOlid(with: book.coverID ?? "")
        bookNameLabel.text = book.title
        authorNameLabel.text = book.author
        
    }
}
