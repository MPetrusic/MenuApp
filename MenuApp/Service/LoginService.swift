//
//  LoginService.swift
//  MenuApp
//
//  Created by Milos Petrusic on 7.11.22..
//

import Foundation

final class LoginService {
    func login(email: String, password: String, completion: @escaping (Result<LoginResponse, MenuError>) -> Void) {
        let params = ["email": email, "password": password]
        NetworkManager.shared.performRequest(type: EndPointItem.login, params: params) { (response: LoginResponse?, error: MenuError?) in
            if let response {
                if let responseData = response.data {
                    LocalStorage.save(token: responseData.token?.value ?? "")
                    completion(.success(response))
                }
            } else if let error {
                completion(.failure(error))
            } else {
                completion(.failure(.unknownError))
            }
        }
    }
}
