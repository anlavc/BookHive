//
//  SearchTableViewCell.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 12.04.2023.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    // MARK: - Identifier
    static let identifier = "SearchTableViewCell"
    
    // MARK: - Properties
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    // MARK: - Awake From Nib
    override func awakeFromNib() {
        super.awakeFromNib()
        viewConfigure()
    }
    
    // MARK: - View Configure
    private func viewConfigure() {
        searchView.layer.cornerRadius = 20
        searchView.layer.shadowColor = UIColor.gray.cgColor
        searchView.layer.shadowOffset = CGSize(width: 2,
                                               height: 2)
        searchView.layer.shadowOpacity = 0.5
    }
    
    // MARK: - Nib Func.
    static func nib() -> UINib {
        return UINib(nibName: "SearchTableViewCell", bundle: nil)
    }
    
}
