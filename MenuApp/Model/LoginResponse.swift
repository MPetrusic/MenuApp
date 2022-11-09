//
//  LoginResponse.swift
//  MenuApp
//
//  Created by Milos Petrusic on 7.11.22..
//

import Foundation

struct LoginResponse: Codable {
    let data: LoginResponseData?
}

struct LoginResponseData: Codable {
    let token: Token?
}

struct Token: Codable {
    let value: String?
}
