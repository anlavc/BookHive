//
//  HomeCollectionViewCoursel.swift
//  BookHive
//
//  Created by Anıl AVCI on 15.04.2023.
//

import UIKit

class HomeCollectionViewCoursel: UICollectionViewCell {
    
    static let identifier = "HomeCollectionViewCoursel"
    

  
    @IBOutlet weak var bgview: UIView!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.masksToBounds = false
        imageView.layer.shadowOffset = CGSize(width: 0, height: 25)//Blur
        imageView.layer.shadowOpacity = 0.20
        imageView.layer.shadowRadius = 6.0
        imageView.layer.cornerRadius = 10.0
//        imageView.addShadow(offset: CGSize.init(width: 0, height: 25), color: UIColor.gray, radius: 10.0, opacity: 0.45)
    }
   
    static func nib() -> UINib {
        return UINib(nibName: "HomeCollectionViewCoursel", bundle: nil)
    }
}
extension UIImageView {

    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity

        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
}
