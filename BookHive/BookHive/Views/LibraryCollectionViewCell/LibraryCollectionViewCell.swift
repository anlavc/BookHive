//
//  LibraryCollectionViewCell.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 17.04.2023.
//

import UIKit

class LibraryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "LibraryCollectionViewCell"

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    var cellColor: UIColor? {
        didSet {
            guard let cellColor = cellColor else {return}
            self.cellView.backgroundColor = cellColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewsConfig()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "LibraryCollectionViewCell", bundle: nil)
    }
    
    private func viewsConfig() {
        categoryImageView.layer.cornerRadius = 15
        cellView.layer.cornerRadius = 30
    }
    
    public func configure(model: Subjects) {
        categoryNameLabel.text = model.title
    }
    
}
