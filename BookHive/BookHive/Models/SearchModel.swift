//
//  SearchModel.swift
//  BookHive
//
//  Created by Anıl AVCI on 19.04.2023.
//

import Foundation
// MARK: - SearchModel
struct SearchModel: Codable {
    let numFound, start: Int?
    let numFoundExact: Bool?
    let docs: [SearchDoc]?
    let searchModelNumFound: Int?
    let q: String?
    let offset: NSNull?
}

// MARK: - Doc
struct SearchDoc: Codable {
    let key: String?
    let title: String?
    let authorName: [String]?
    let subject: [String]?
    let coverEditionKey: String?
    let coverI: Int?
}

