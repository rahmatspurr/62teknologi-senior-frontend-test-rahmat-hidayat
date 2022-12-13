//
//  PaginationBusinessesModel.swift
//  business
//
//  Created by Rahmat Hidayat on 09/12/22.
//

import Foundation

struct PaginationBusinesses: Codable {
    var businesses: [Businesses]
    var total: Int
    
    enum CodingKeys: String, CodingKey {
        case businesses
        case total
    }
}

struct PaginationReviews: Codable {
    var reviews: [Review]
    var total: Int
    
    enum CodingKeys: String, CodingKey {
        case reviews
        case total
    }
}
