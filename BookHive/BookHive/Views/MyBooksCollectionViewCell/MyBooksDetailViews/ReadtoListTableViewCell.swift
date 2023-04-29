//
//  ReadtoListTableViewCell.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 29.04.2023.
//

import UIKit

class ReadtoListTableViewCell: UITableViewCell {
    
   static let identifier = "ReadtoListTableViewCell"
    
    @IBOutlet weak var readToListView: UIView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setViews()
    }
    
    private func setViews() {
        readToListView.layer.cornerRadius = 15
        readToListView.addShadow(color: .gray,
                                 opacity: 0.5,
                                 offset: CGSize(width: 2,
                                                height: 2),
                                 radius: 5)
    }
    
    
    static func nib() -> UINib {
        return UINib(nibName: "ReadtoListTableViewCell", bundle: nil)
    }
    
}
