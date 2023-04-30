//
//  BookEndPoint.swift
//  BookHive
//
//  Created by Anıl AVCI on 14.04.2023.
//
//https://openlibrary.org/subjects/new_york_times_bestseller
//https://covers.openlibrary.org/b/id/13775629-L.jpg

import Foundation

enum BookEndPoint {
    case now
    case cover(isbn: String)
    case bestseller
    case search(search: String)
    case detail(detail: String)
    case pageNumber(olid: String)
    case week
    case yearly
    case rating(olid: String)
}
extension BookEndPoint: EndPointType {
    var path: String {
        switch self {
        case .now:
            return "trending/now.json?limit=20"
        case .cover(isbn: let isbn):
            return "b/isbn/\(isbn)-L.jpg"
        case .bestseller:
            return "subjects/new_york_times_bestseller.json?limit=20"
        case .search(let search):
            return "\(search)"
        case .detail(let detail):
            return "\(detail).json"
        case .pageNumber(let olid):
            return "\(olid).json"
        case .week:
            return "trending/weekly.json?limit=20"
        case .yearly:
            return "trending/yearly.json?limit=20"
        case .rating:
            return "ratings.json"
            
        }
    }
    var baseURL: String {
        switch self {
        case .now:
            return "https://openlibrary.org"
        case .cover:
            return "https://covers.openlibrary.org"
        case .bestseller:
            return "https://openlibrary.org"
        case .search:
            return "https://openlibrary.org/search.json?q="
        case .detail:
            return "https://openlibrary.org/works"
        case .pageNumber:
            return "https://openlibrary.org/books"
        case .week:
            return "https://openlibrary.org"
        case .yearly:
            return "https://openlibrary.org"
        case .rating(let olid):
            return "https://openlibrary.org\(olid)"
        }
    }
    var url: URL? {
        return URL(string: "\(baseURL)/\(path)")
    }
    var method: HTTPMethods {
        switch self {
        case .now:
            return .get
        case .cover:
            return .get
        case .bestseller:
            return .get
        case .search:
            return .get
        case .detail:
            return .get
        case .pageNumber:
            return .get
        case .week:
            return .get
        case .yearly:
            return .get
        case .rating:
            return .get
        }
    }
}
//
//    func fetchCategories(completion: @escaping ([String]?, Error?) -> Void) {
//        guard let url = URL(string: "https://openlibrary.org/subjects.json?limit=10") else {
//            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil else {
//                completion(nil, error)
//                return
//            }
//
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//                let categories = json?["works"] as? [String] ?? []
//                completion(categories, nil)
//            } catch {
//                completion(nil, error)
//            }
//        }
//
//        task.resume()
//    }
//
//}
