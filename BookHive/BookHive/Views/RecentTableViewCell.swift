//
//  RecentTableViewCell.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 13.04.2023.
//

import UIKit

class RecentTableViewCell: UITableViewCell {
    
    // MARK: - Identifier
    static let identifier = "RecentTableViewCell"
    
    // MARK: - Properties
    @IBOutlet weak var recentLabel: UILabel!
    
    // MARK: - Awake From Nib
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Nib Func.
    static func nib() -> UINib {
        return UINib(nibName: "RecentTableViewCell", bundle: nil)
    }

   
    
}
