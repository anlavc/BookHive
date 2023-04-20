//
//  BookEndPoint.swift
//  BookHive
//
//  Created by Anıl AVCI on 14.04.2023.
//
//https://openlibrary.org/subjects/new_york_times_bestseller

import Foundation

enum BookEndPoint {
    case trending
    case cover(isbn: String)
    case bestseller
    case search(search: String)
    case detail(detail: String)
}
extension BookEndPoint: EndPointType {
    var path: String {
        switch self {
        case .trending:
            return "trending/daily.json?limit=20"
        case .cover(isbn: let isbn):
            return "b/isbn/\(isbn)-L.jpg"
        case .bestseller:
            return "subjects/new_york_times_bestseller.json?limit=20"
        case .search(let search):
            return "\(search)"
        case .detail(let detail):
            return "\(detail).json"
        }
    }
    var baseURL: String {
        switch self {
        case .trending:
            return "https://openlibrary.org"
        case .cover:
            return "https://covers.openlibrary.org"
        case .bestseller:
            return "https://openlibrary.org"
        case .search:
            return "https://openlibrary.org/search.json?q="
        case .detail:
            return "https://openlibrary.org"
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
        case .bestseller:
            return .get
        case .search:
            return .get
        case .detail:
            return .get
}
    }
}
