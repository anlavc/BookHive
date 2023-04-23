//
//  DetailOlid.swift
//  BookHive
//
//  Created by Anıl AVCI on 22.04.2023.
//

import Foundation


// MARK: - DetailModel2
struct DetailModel2: Codable {
    
    let publishDate: String?
    let publishers: [String]?
    let languages: [TypeElement]?
    let numberOfPages: Int?


    enum CodingKeys: String, CodingKey {
        case numberOfPages = "number_of_pages"
        case publishDate = "publish_date"
        case languages
        case publishers
        
    }
}
// MARK: - TypeElement
struct TypeElement: Codable {
    let key: String?
}
