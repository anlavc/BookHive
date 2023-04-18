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
    let title: String?
    let cover_i: Int? 
    let cover_id: Int?
    let availability: Availability?
}

// MARK: - Availability
struct Availability: Codable {
    
    let isbn: String?
    let openlibrary_edition: String?
   
    
}
