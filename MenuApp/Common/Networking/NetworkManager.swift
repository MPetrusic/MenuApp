//
//  NetworkManager.swift
//  MenuApp
//
//  Created by Milos Petrusic on 7.11.22..
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    func performRequest<T: Decodable>(type: EndPointType, params: [String: Any], completion: @escaping (T?, _ error: MenuError?) -> ()) {
        let session = URLSession.shared
        var request = createRequest(with: type)
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params) else { return }
        request.httpBody = httpBody
        
        session.dataTask(with: request) { [weak self] data, response, error in
            guard let self else { return }
            
            if let response {
                if !self.validate(response) {
                    completion(nil, .invalidStatusCode)
                    return
                }
            }
            
            if let _ = error {
                completion(nil, .networkFailure)
                return
            }
            
            if let data {
                do {
                    try completion(self.result(from: data), nil)
                } catch {
                    completion(nil, .jsonParsingError)
                }
                return
            }
        }.resume()
    }
    
    func performRequest(type: EndPointType, params: [String: Any], completion: @escaping (()?, _ error: MenuError?) -> ()) {
        let session = URLSession.shared
        let request = createRequest(with: type)
        
        session.dataTask(with: request) { [weak self] data, response, error in
            guard let self else { return }
            
            if let response {
                if !self.validate(response) {
                    completion(nil, .invalidStatusCode)
                    return
                }
            }
            
            if let _ = error {
                completion(nil, .networkFailure)
                return
            }
            
            if let _ = data {
                completion((), nil)
                return
            }
        }.resume()
    }
}

private extension NetworkManager {
    func createRequest(with type: EndPointType) -> URLRequest {
        var request = URLRequest(url: type.url)
        request.httpMethod = type.httpMethod.rawValue
        request.allHTTPHeaderFields = type.headers
        return request
    }
    
    func validate(_ response: URLResponse) -> Bool {
        if let response = response as? HTTPURLResponse,
           response.statusCode < 200 || response.statusCode >= 300 {
            return false
        }
        
        return true
    }
    
    func result<T: Decodable>(from data: Data) throws -> T {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch let error {
            throw error
        }
    }
}
