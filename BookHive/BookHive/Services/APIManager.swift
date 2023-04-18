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
