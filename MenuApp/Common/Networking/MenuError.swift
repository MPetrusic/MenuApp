//
//  MenuError.swift
//  MenuApp
//
//  Created by Milos Petrusic on 7.11.22..
//

import Foundation

enum MenuError: Error {
    case invalidStatusCode
    case unknownError
    case networkFailure
    case jsonParsingError
}
