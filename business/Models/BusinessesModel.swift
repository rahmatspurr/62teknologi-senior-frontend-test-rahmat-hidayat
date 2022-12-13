//
//  BusinessesModel.swift
//  business
//
//  Created by Rahmat Hidayat on 09/12/22.
//

import Foundation

struct Businesses: Codable {
    var id: String?
    var name: String?
    var imageURL: String?
    var isClosed: Bool?
    var url: String?
    var reviewCount: Int?
    var rating: Double?
    var coordinates: Coordinates?
    var location: Location?
    var photos: [String]?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageURL = "image_url"
        case isClosed = "is_closed"
        case url
        case reviewCount = "review_count"
        case rating
        case coordinates
        case location
        case photos
    }
}
