//
//  LibraryModel.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 22.04.2023.
//

import Foundation

// MARK: - Library Model
struct LibraryModel: Codable {
    let title: [Subjects]?
}

struct Subjects: Codable {
    let title: String
}
