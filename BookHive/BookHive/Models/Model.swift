//
//  Model.swift
//  BookHive
//
//  Created by Anıl AVCI on 14.04.2023.
//

import Foundation

import Foundation

// MARK: - Bookhive
struct Bookhive: Codable {
    let query: String?
    let works: [Work]!
    let days, hours: Int?
}

// MARK: - Work
struct Work: Codable {
    let key, title: String?
    let firstPublishYear: Int?
    let language, authorKey, authorName: [String]?
    let coverEditionKey: String?
    let coverI: Int?
    let ia: [String]?
    let subtitle: String?
}

