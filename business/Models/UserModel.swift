//
//  UserModel.swift
//  business
//
//  Created by Rahmat Hidayat on 10/12/22.
//

import Foundation

struct User: Codable {
    var id: String?
    var imageUrl: String?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case id
        case imageUrl = "image_url"
        case name
    }
}
