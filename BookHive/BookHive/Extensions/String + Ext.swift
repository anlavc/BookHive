//
//  String + Ext.swift
//  BookHive
//
//  Created by Anıl AVCI on 28.04.2023.
//

import Foundation

extension String {
    var isNilOrEmpty: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty != false
    }
}
