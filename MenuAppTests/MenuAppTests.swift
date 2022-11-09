//
//  MenuAppTests.swift
//  MenuAppTests
//
//  Created by Milos Petrusic on 7.11.22..
//

import XCTest
@testable import MenuApp

final class MenuAppTests: XCTestCase {

    var controller: VenuesViewController = VenuesViewController()
    var venues: [Venue] = []
    
    override func setUpWithError() throws {
        controller.setVenueService(MockVenueService())
        controller.venueService?.getVenues(latitude: "", longitude: "", completion: { [weak self] result in
            switch result {
            case .success(let venuesData):
                if let mockVenues = venuesData.venues {
                    self?.venues = mockVenues
                }
            case .failure(_):
                self?.venues = []
            }
        })
    }
    
    func testVenuesCountAfterFetching() {
        XCTAssertEqual(venues.count, 2)
    }
    
    func testVenueNameDecoding() {
        XCTAssertEqual(venues[0].venue?.name, "Test1")
    }
}
