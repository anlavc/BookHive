//
//  TextfieldCharacters + Ext.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 23.04.2023.
//

import UIKit

extension UITextField {
    func turkishText() -> String? {
        guard let text = self.text else {return nil}
        let turkishText = text
            .replacingOccurrences(of: " ", with: "+")
            .replacingOccurrences(of: "ı", with: "i")
            .replacingOccurrences(of: "ş", with: "s")
            .replacingOccurrences(of: "ç", with: "c")
            .replacingOccurrences(of: "ğ", with: "g")
            .replacingOccurrences(of: "ö", with: "o")
            .replacingOccurrences(of: "ü", with: "u")
            .replacingOccurrences(of: "I", with: "İ")
            .replacingOccurrences(of: "Ş", with: "S")
            .replacingOccurrences(of: "Ç", with: "C")
            .replacingOccurrences(of: "Ğ", with: "G")
            .replacingOccurrences(of: "Ö", with: "O")
            .replacingOccurrences(of: "Ü", with: "U")
        return turkishText
    }
}
