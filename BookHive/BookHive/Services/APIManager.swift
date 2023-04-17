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
    case newtwork(Error?)
}
//typealias Handler = (Result<[Product], DataError >) -> Void
typealias Handler<T> = (Result<T, DataError >) -> Void
class APIManager {
    static let shared = APIManager()
    private init() {}
    
    func request<T: Codable>(
        modelType: T.Type,
        type: EndPointType,
        complation: @escaping Handler<T>
    ) {
        guard let url = type.url else {
            complation(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = type.method.rawValue
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data, error == nil else {
                complation(.failure(.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else {
                complation(.failure(.invalidResponse))
                return
            }
            do {
                let product = try JSONDecoder().decode(modelType, from: data)
                complation(.success(product))
            } catch {
                complation(.failure(.newtwork(error)))
            }
        }.resume()
    }
    
    static var commonheaders: [String: String] {
        return [
            "Content-Type": "application/json"
        ]
    }
}
