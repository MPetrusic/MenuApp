//
//  Identifiable+Extension.swift
//  MenuApp
//
//  Created by Milos Petrusic on 7.11.22..
//

import Foundation

protocol Identifiable: AnyObject {
    static var identifier: String { get }
}

extension Identifiable {
    
    static var identifier: String {
        return String(describing: self)
    }
}
