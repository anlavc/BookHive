//
//  Rating.swift
//  BookHive
//
//  Created by Anıl AVCI on 25.04.2023.
//

import Foundation

// MARK: - Rating
struct Rating: Codable {
    let summary: Summary?
   
}

// MARK: - Summary
struct Summary: Codable {
    let average: Double?
 
}
