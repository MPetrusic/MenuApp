//
//  LocalStorage.swift
//  MenuApp
//
//  Created by Milos Petrusic on 7.11.22..
//

import Foundation

final class LocalStorage {
    
    private static let tokenKey = "LoginTokenKey"
    private static var token: String? {
        if let token = UserDefaults.standard.string(forKey: tokenKey) {
            return token
        } else {
            return nil
        }
    }
    
    static var isUserLoggedIn: Bool {
        return token != nil
    }
    
    static func save(token: String) {
        UserDefaults.standard.set(token, forKey: tokenKey)
    }
    
    static func deleteLoginData() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }
}
