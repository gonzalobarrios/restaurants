//
//  RestaurantsData.swift
//  Restaurants
//
//  Created by Gonzalo on 11/12/22.
//

import Foundation

struct RestaurantData: Decodable {

    let restaurants: [Restaurant]
    
    enum CodingKeys: String, CodingKey {
        case restaurants = "data"
    }

}
