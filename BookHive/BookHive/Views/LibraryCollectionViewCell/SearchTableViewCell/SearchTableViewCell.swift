//
//  SearchTableViewCell.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 12.04.2023.
//

import UIKit
import Kingfisher

class SearchTableViewCell: UITableViewCell {

    var isFavorited = false
    
    // MARK: - Outlets
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var viewDetailsButton: UIButton!
    
    // MARK: - Identifier
    static let identifier = "SearchTableViewCell"
    
    // MARK: - AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        viewConfigure()
    }
    
    // MARK: - Nib Func.
    static func nib() -> UINib {
        return UINib(nibName: "SearchTableViewCell", bundle: nil)
    }
    
    // MARK: - Views Config
    private func viewConfigure() {
        searchView.layer.cornerRadius = 20
        searchView.addShadow(color  : .gray,
                             opacity: 0.5,
                             offset : CGSize(width: 2, height: 2),
                             radius : 5)
    }
    
    // MARK: - Search Cell Config
    public func searchConfig(model: SearchDoc) {
        bookNameLabel.text = model.title
        let authorNames = model.author_name?.joined(separator: ", ")
        authorNameLabel.text = authorNames
       
    }
    
    // MARK: - Search Favorite Button Action
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        isFavorited.toggle()
        let bookFavorite = isFavorited ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: bookFavorite), for: .normal)
    }
    
    // MARK: - Search Details Button Action
    @IBAction func viewDetailsButtonTapped(_ sender: UIButton) {
    }
}

extension UIImageView {
    func setImageCoverI(with cover_i: String) {
        let urlString = "https://covers.openlibrary.org/b/id/\(cover_i)-L.jpg"
        guard let url = URL(string: urlString) else { return }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        print("-----> olid URL SERVİCES \(urlString)")
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
    
    func setCover(with cover: Int) {
        let urlString = "https://covers.openlibrary.org/b/id/\(cover)-L.jpg"
        guard let url = URL(string: urlString) else { return }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        print("-----> cover URL SERVİCES \(urlString)")
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
}
