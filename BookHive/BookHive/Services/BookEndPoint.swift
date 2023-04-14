//
//  BookEndPoint.swift
//  BookHive
//
//  Created by Anıl AVCI on 14.04.2023.
//

import Foundation

enum ProductEndPoint {
    case trending
    case now
}
extension ProductEndPoint: EndPointType {
    var path: String {
        switch self {
        case .trending:
            return "trending"
        case .now:
            return "now"
            
        }
    }
    var baseURL: String {
        switch self {
        case .trending:
            return "https://openlibrary.org"
        case .now:
            return "/now"
        }
    }
    var url: URL? {
        return URL(string: "\(baseURL)/\(path).json")
    }
    var method: HTTPMethods {
        switch self {
        case .trending:
            return .get
            
        case .now:
            return .get
        }
    }
    var body: Encodable? {
        switch self {
        case .trending:
            return nil
        case .now:
            return nil
        }
    }
}
