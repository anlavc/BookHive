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
}

// MARK: - Doc
struct SearchDoc: Codable {
    let key: String?
    let title: String?
    let author_name: [String]?
    let subject: [String]?
    let cover_edition_key: String?
    let cover_i: Int?
    let language: [String]?
    let edition_key: [String]?
}

