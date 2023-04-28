//
//  UIView + Ext.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 13.04.2023.
//

import UIKit

extension UIView {
    func addShadow(color  : UIColor,
                   opacity: Float,
                   offset : CGSize,
                   radius : CGFloat)
    {
        layer.shadowColor   = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset  = offset
        layer.shadowRadius  = radius
    }
}
