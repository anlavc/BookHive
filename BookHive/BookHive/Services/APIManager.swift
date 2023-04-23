//
//  APIManager.swift
//  BookHive
//
//  Created by Anıl AVCI on 14.04.2023.
//

import UIKit

/// Error Case
enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
}
//typealias Handler = (Result<[Product], DataError >) -> Void
typealias Handler<T> = (Result<T, DataError >) -> Void
class APIManager {
    static let shared = APIManager()
    private init() {}
    
    func request<T: Codable>(
        modelType: T.Type,
        type: EndPointType,
        completion: @escaping Handler<T>
    ) {
        guard let url = type.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = type.method.rawValue
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            do {
                let product = try JSONDecoder().decode(modelType, from: data)
                completion(.success(product))
            } catch {
                completion(.failure(.network(error)))
            }
        }.resume()
    }
    
//    static var commonheaders: [String: String] {
//        return [
//            "Content-Type": "application/json"
//        ]
//    }
}

//func jsonDataDecoder() {
//   
//    
//    var request = URLRequest(url: URL(string: "https://openlibrary.org/api/books?bibkeys=olid:OL24274306M&jscmd=details&format=json")!)
//    URLSession.shared.dataTask(with: request) { data, response, error in
//        
//        guard let data, error == nil else {
//            return
//        }
//        guard let response = response as? HTTPURLResponse,
//              200 ... 299 ~= response.statusCode else {
//            return
//        }
//        do {
//            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                    // try to read out a string array
//                if let names = json["olid:OL24274306M"] as? [String: Any],
//                   let details = names["details"] as? [String:Any],
//                   let publisher = details["publishers"] as? [String],
//                   let title = details["title"] as? String
//                {
//                  
//                    let olidModel = OlidModel(publishers: publisher, title: title)
//                    print(olidModel)
//                 
//                    }
//                }
//        } catch {
//        }
//    }.resume()
//}
//struct OlidModel {
//    let publishers: [String]
//    let title: String
//}
