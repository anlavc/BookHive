//
//  BookEndPoint.swift
//  BookHive
//
//  Created by Anıl AVCI on 14.04.2023.
//

import Foundation

enum BookEndPoint {
    case trending
    case cover(isbn: String)
    
}
extension BookEndPoint: EndPointType {
    var path: String {
        switch self {
        case .trending:
            return "trending/daily.json"
            
            
        case .cover(isbn: let isbn):
            return "b/isbn/\(isbn)-L.jpg"
        }
    }
    var baseURL: String {
        switch self {
        case .trending:
            return "https://openlibrary.org"
            
        case .cover:
            return "https://covers.openlibrary.org"
        }
    }
    var url: URL? {
        return URL(string: "\(baseURL)/\(path)")
    }
    var method: HTTPMethods {
        switch self {
        case .trending:
            return .get
            
            
        case .cover:
            return .get
        }
//        var body: Encodable? {
//            switch self {
//            case .trending:
//                return nil
//                
//            case .cover:
//                return nil
//            }
//        }
    }
}
