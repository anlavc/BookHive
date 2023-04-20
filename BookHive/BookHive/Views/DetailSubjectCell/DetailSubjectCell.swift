//
//  DetailSubjectCell.swift
//  BookHive
//
//  Created by Anıl AVCI on 20.04.2023.
//

import UIKit

class DetailSubjectCell: UICollectionViewCell {
    static let identifier = "DetailSubjectCell"
    @IBOutlet weak var subjectLabel: UILabel!
    
    @IBOutlet weak var bgview: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
      
        bgview.layer.cornerRadius = 14
        bgview.clipsToBounds = true
    }
    static func nib() -> UINib {
        return UINib(nibName: "DetailSubjectCell", bundle: nil)
    }
}
