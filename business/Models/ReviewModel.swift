//
//  ReviewModel.swift
//  business
//
//  Created by Rahmat Hidayat on 10/12/22.
//

import Foundation

struct Review: Codable {
    var id: String?
    var text: String?
    var rating: Double?
    var timeCreated: String?
    var user: User?

    enum CodingKeys: String, CodingKey {
        case id
        case text
        case rating
        case timeCreated = "time_created"
        case user
    }
}
