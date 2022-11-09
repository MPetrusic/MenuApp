//
//  EndPointType.swift
//  MenuApp
//
//  Created by Milos Petrusic on 7.11.22..
//

import Foundation

protocol EndPointType {
    var baseUrlString: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String: String]? { get }
    var url: URL { get }
}

enum HTTPMethod: String {
    case GET
    case POST
}
