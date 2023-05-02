//
//  Date + Ext.swift
//  BookHive
//
//  Created by Anıl AVCI on 1.05.2023.
//

import Foundation

extension Date {
    func toFormattedString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }
}
