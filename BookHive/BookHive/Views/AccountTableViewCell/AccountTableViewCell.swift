//
//  AccountTableViewCell.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 18.04.2023.
//

import UIKit
import Eureka

class AccountTableViewCell: Cell<String>, CellType {
    
    
    @IBOutlet weak var accountCellView: UIView!
    @IBOutlet weak var accountIconImageView: UIImageView!
    @IBOutlet weak var accountTableViewCellLabelName: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
