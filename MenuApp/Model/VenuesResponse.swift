//
//  VenuesResponse.swift
//  MenuApp
//
//  Created by Milos Petrusic on 7.11.22..
//

import Foundation

struct VenuesResponse: Codable {
    let data: VenuesResponseData?
}

struct VenuesResponseData: Codable {
    let venues: [Venue]?
}

struct Venue: Codable {
    let distance: Double?
    let venue: VenueDetails?
    
    var distanceInKilometers: String? {
        get {
            if let distance {
                let formattedDistanceString = String(format: "%.1f", distance / 1000.0)
                return formattedDistanceString + "km"
            } else {
                return nil
            }
        }
    }
}

struct VenueDetails: Codable {
    let name: String?
    let address: String?
    let servingTimes: [ServingTimes]?
    let isOpen: Bool?
    let description: String?
    let welcomeMessage: String?
    let image: VenueImage?

    enum CodingKeys: String, CodingKey {
        case name
        case address
        case servingTimes = "serving_times"
        case isOpen = "is_open"
        case description
        case welcomeMessage = "welcome_message"
        case image
    }
}

struct ServingTimes: Codable {
    let timeFrom: String?
    let timeTo: String?
    
    var servingTime: String? {
        get {
            return "\(timeFrom ?? "") - \(timeTo ?? "")"
        }
    }

    enum CodingKeys: String, CodingKey {
        case timeFrom = "time_from"
        case timeTo = "time_to"
    }
}

struct VenueImage: Codable {
    let thumbnailMedium: String?

    enum CodingKeys: String, CodingKey {
        case thumbnailMedium = "thumbnail_medium"
    }
}

// MARK: - Mock

extension VenuesResponseData {
    static let mockVenuesData = VenuesResponseData(venues: mockVenues)
    static let mockVenues: [Venue] = [
        Venue(distance: 1.0, venue: .init(name: "Test1", address: nil, servingTimes: nil, isOpen: nil, description: nil, welcomeMessage: nil, image: nil)),
        Venue(distance: 2.0, venue: .init(name: "Test2", address: nil, servingTimes: nil, isOpen: nil, description: nil, welcomeMessage: nil, image: nil))
    ]
}
