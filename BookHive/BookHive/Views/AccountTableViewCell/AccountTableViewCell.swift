//
//  AccountTableViewCell.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 18.04.2023.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
    
    static let identifier = "AccountTableViewCell"
    
    @IBOutlet weak var accountCellView: UIView!
    @IBOutlet weak var accountIconImageView: UIImageView!
    @IBOutlet weak var accountTableViewCellLabelName: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        viewConfigure()
        
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "AccountTableViewCell", bundle: nil)
    }
    
    private func viewConfigure() {
        accountCellView.addShadow(color: .gray, opacity: 0.5, offset: CGSize(width: 2, height: 2), radius: 5)
    }

   
    
}
