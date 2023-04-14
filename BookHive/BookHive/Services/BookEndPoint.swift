//
//  BookEndPoint.swift
//  BookHive
//
//  Created by Anıl AVCI on 14.04.2023.
//

import Foundation

enum ProductEndPoint {
    case trending
}
extension ProductEndPoint: EndPointType {
    var path: String {
        switch self {
        case .trending:
            return "trending/now&page=1"
        }
    }
    var baseURL: String {
        switch self {
        case .trending:
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
            
        }
    }
    var body: Encodable? {
        switch self {
        case .trending:
            return nil
        }
    }
}
