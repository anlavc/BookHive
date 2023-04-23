//
//  DetailModel.swift
//  BookHive
//
//  Created by Anıl AVCI on 20.04.2023.
//

import Foundation
// MARK: - DetailModel
struct DetailModel: Codable {
//    let title, key: String!
    let authors: [Author]?
    let description: Created?
    let subjects: [String]?
//    let covers: [Int]?
  
}
// MARK: - Author
struct Author: Codable {
    let key: String?
}
// MARK: - Created
struct Created: Codable {
    let type, value: String?
}
