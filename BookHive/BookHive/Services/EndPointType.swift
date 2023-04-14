//
//  EndPointType.swift
//  BookHive
//
//  Created by Anıl AVCI on 14.04.2023.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
}

protocol EndPointType {
    var path: String {get}
    var baseURL: String {get}
    var url: URL? {get}
    var method: HTTPMethods {get}
    //    var body: Encodable? {get}
    //    var headers: [String: String]? {get}
}
