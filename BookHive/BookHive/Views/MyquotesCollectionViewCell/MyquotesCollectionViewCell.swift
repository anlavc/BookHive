//
//  MyquotesCollectionViewCell.swift
//  BookHive
//
//  Created by Anıl AVCI on 3.05.2023.
//

import UIKit

class MyquotesCollectionViewCell: UICollectionViewCell {
    static let identifier = "MyquotesCollectionViewCell"
    
    @IBOutlet weak var bgview: UIView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var quoteTextField: UITextView!
    @IBOutlet weak var pageNumberLabel: UILabel!
    @IBOutlet weak var bookNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgview.layer.cornerRadius = 20
        bgview.addShadow(color: .white, opacity: 0.5, offset: CGSize(width: 2, height: 2), radius: 5)
        
    }
    static func nib() -> UINib {
        return UINib(nibName: "MyquotesCollectionViewCell", bundle: nil)
    }
    
}
