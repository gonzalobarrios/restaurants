//
//  Restaurant.swift
//  Restaurants
//
//  Created by Gonzalo on 11/12/22.
//

import Foundation

struct Restaurant: Decodable, Equatable {
    let uuid: String
    let name: String
    let ratings: Ratings
    let address: Address
    let mainPhoto: MainPhoto?

    enum CodingKeys: String, CodingKey {
        case uuid
        case name
        case ratings = "aggregateRatings"
        case address
        case mainPhoto
    }
    
    static func == (lhs: Restaurant, rhs: Restaurant) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
