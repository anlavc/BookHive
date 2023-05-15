//
//  isValidEmailPassword + Ext.swift
//  BookHive
//
//  Created by Anıl AVCI on 28.04.2023.
//

import Foundation

class Utilities {
   static func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    static func isPasswordValid(_ password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{6,}$")
        let passwordTestWithSpecialChar = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$%^&*()_+]).{6,}$")
        
        return passwordTest.evaluate(with: password) || passwordTestWithSpecialChar.evaluate(with: password)
    }
}
