//
//  ReadListCollectionViewCell.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 30.04.2023.
//

import UIKit
import Firebase
import FirebaseAuth

protocol ReadListCollectionViewCellDelegate {
    func deleteItem(indexPath: IndexPath)
}

class ReadListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ReadListCollectionViewCell"
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var readButton: UIButton!
    
    var detailID: String?
    var collectionView: ReadListViewController?
    var delegate: ReadListCollectionViewCellDelegate?
    var indexPath: IndexPath?
    var book: Book?
    
    
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
    
    public func configure(model: Book) {
        bookImageView.setImageOlid(with: model.coverID ?? "")
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        if let indexPath = indexPath {
            delegate?.deleteItem(indexPath: indexPath)
            collectionView?.deleteItem(indexPath: indexPath)
        }
    }


    
    @IBAction func readButtonTapped(_ sender: UIButton) {
        
    }
}
