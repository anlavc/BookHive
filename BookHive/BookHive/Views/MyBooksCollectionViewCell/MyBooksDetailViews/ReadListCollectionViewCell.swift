//
//  ReadListCollectionViewCell.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 30.04.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class ReadListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ReadListCollectionViewCell"
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var readButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bookImageView.layer.cornerRadius = 15
        bookImageView.addShadow(color: .white, opacity: 0.5, offset: CGSize(width: 2, height: 2), radius: 5)
        listView.layer.cornerRadius = 20
        listView.addShadow(color: .gray, opacity: 0.5, offset: CGSize(width: 2, height: 2), radius: 5)
        deleteButton.layer.cornerRadius = 8
        readButton.layer.cornerRadius = 8
        
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ReadListCollectionViewCell", bundle: nil)
    }
    
    public func configure(with: Book) {
        bookImageView.setImageOlid(with: with.coverID)
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func readButtonTapped(_ sender: UIButton) {
        
    }
}
