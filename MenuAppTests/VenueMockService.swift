//
//  VenueMockService.swift
//  MenuAppUITests
//
//  Created by Milos Petrusic on 9.11.22..
//

import Foundation
@testable import MenuApp

final class MockVenueService: VenueServiceProvider {
    func getVenues(latitude: String, longitude: String, completion: @escaping (Result<MenuApp.VenuesResponseData, MenuApp.MenuError>) -> Void) {
        completion(.success(VenuesResponseData.mockVenuesData))
    }
}
