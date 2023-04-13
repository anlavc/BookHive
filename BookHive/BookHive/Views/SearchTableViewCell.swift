//
//  SearchTableViewCell.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 12.04.2023.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
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
        searchView.layer.shadowColor = UIColor.gray.cgColor
        searchView.layer.shadowOpacity = 0.5
        searchView.layer.shadowRadius = 5
        searchView.layer.shadowOffset = CGSize(width: 2,
                                               height: 2)
    }
    
}
