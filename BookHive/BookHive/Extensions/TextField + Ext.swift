//
//  TextField + Ext.swift
//  BookHive
//
//  Created by Anıl AVCI on 26.04.2023.
//
import UIKit

extension UITextField {
    
    // textfield bgcolor and image
    func setIcon(_ image: UIImage,borderWidth: CGFloat, borderColor: UIColor, cornerRadius: CGFloat) {
       let iconView = UIImageView(frame:
                      CGRect(x: 16, y: 6, width: 22, height: 18))
        iconView.tintColor = UIColor.systemBrown
       iconView.image = image
       let iconContainerView: UIView = UIView(frame:
                      CGRect(x: 16, y: 0, width: 45, height: 30))
       iconContainerView.addSubview(iconView)
       leftView = iconContainerView
       leftViewMode = .always
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = cornerRadius
    }

    

}
