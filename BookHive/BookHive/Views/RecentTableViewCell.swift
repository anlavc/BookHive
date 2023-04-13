//
//  RecentTableViewCell.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 13.04.2023.
//

import UIKit

class RecentTableViewCell: UITableViewCell {
    
    static let identifier = "RecentTableViewCell"
    
    @IBOutlet weak var recentLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "RecentTableViewCell", bundle: nil)
    }

   
    
}
