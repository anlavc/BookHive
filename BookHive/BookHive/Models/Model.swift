//
//  Model.swift
//  BookHive
//
//  Created by Anıl AVCI on 14.04.2023.
//

import Foundation

// MARK: - Bookhive
struct Bookhive: Codable {
   
    let query: String?
    let works: [Work]!
    let days, hours: Int?
}

// MARK: - Work
struct Work: Codable {
    let key: String?
    let title: String?
    let cover_i: Int?
    let cover_id: Int?
    let availability: Availability?
    let language: [String]?
    let cover_edition_key: String?
    let author_name: [String]?
    let authors: [Authors]?
    let first_publish_year: Int?
}

// MARK: - Availability
struct Availability: Codable {
    
    let isbn: String?
    let openlibrary_edition: String?
}

struct Authors: Codable {
    
    let name: String?

}

