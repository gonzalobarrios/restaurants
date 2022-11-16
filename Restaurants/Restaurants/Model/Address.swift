//
//  Address.swift
//  Restaurants
//
//  Created by Gonzalo on 11/12/22.
//

import Foundation

struct Address: Decodable {

    let street: String
    let postalCode: String
    let locality: String
    let country: String

}
