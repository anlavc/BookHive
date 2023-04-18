//
//  SearchTableViewCell.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 12.04.2023.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    var isFavorited = false
        
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var favoriteView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    static let identifier = "SearchTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        viewConfigure()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "SearchTableViewCell", bundle: nil)
    }
    
    private func viewConfigure() {
        searchView.layer.cornerRadius = 20
        searchView.addShadow(color: .gray, opacity: 0.5, offset: CGSize(width: 2, height: 2), radius: 5)
        favoriteView.addShadow(color: .gray, opacity: 0.5, offset: CGSize(width: 2, height: 2), radius: 5)
        favoriteView.layer.cornerRadius = 10
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        isFavorited.toggle()
        let bookFavorite = isFavorited ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: bookFavorite), for: .normal)
    }
}
