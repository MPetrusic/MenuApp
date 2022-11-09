//
//  EndPointItem.swift
//  MenuApp
//
//  Created by Milos Petrusic on 7.11.22..
//

import Foundation

enum EndPointItem {
    case login
    case getVenues
}

extension EndPointItem: EndPointType {
    var baseUrlString: String {
        "https://api-qa.menu.app/api/"
    }
    
    var path: String {
        switch self {
        case .login:
            return "customers/login"
        case .getVenues:
            return "directory/search"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .POST
    }
    
    var headers: [String : String]? {
        return [
            "application": "55c2b09be425e25719f6c9950a281a35",
            "Content-Type": "application/json",
            "Device-UUID": "123456",
            "Api-Version": "3.7.0",
        ]
    }
    
    var url: URL {
        guard let url = URL(string: baseUrlString + path) else {
            fatalError("Can not create base url!")
        }
        return url
    }
}
