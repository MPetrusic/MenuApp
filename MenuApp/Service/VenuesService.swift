//
//  VenuesService.swift
//  MenuApp
//
//  Created by Milos Petrusic on 7.11.22..
//

import Foundation

protocol VenueServiceProvider {
    func getVenues(latitude: String, longitude: String, completion: @escaping (Result<VenuesResponseData, MenuError>) -> Void)
}

final class VenuesService: VenueServiceProvider {
    func getVenues(latitude: String, longitude: String, completion: @escaping (Result<VenuesResponseData, MenuError>) -> Void) {
        let params = ["latitude": latitude, "longitude": longitude]
        NetworkManager.shared.performRequest(type: EndPointItem.getVenues, params: params) { (response: VenuesResponse?, error: MenuError?) in
            if let error {
                completion(.failure(error))
            }
            
            if let response {
                if let responseData = response.data {
                    completion(.success(responseData))
                }
            }
        }
    }
}
