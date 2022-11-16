//
//  MainPhoto.swift
//  Restaurants
//
//  Created by Gonzalo on 11/15/22.
//

import Foundation

struct MainPhoto: Decodable {
    let source: String?
    let s612x344: String?
    let s480x270: String?
    let s240x135: String?
    let s664x374: String?
    let s1350x759: String?
    let s160x120: String?
    let s80x60: String?
    let s92x92: String?
    let s184x184: String?
    
    enum CodingKeys: String, CodingKey {
        case source
        case s612x344 = "612x344"
        case s480x270 = "480x270"
        case s240x135 = "240x135"
        case s664x374 = "664x374"
        case s1350x759 = "1350x759"
        case s160x120 = "160x120"
        case s80x60 = "80x60"
        case s92x92 = "92x92"
        case s184x184 = "184x184"
    }
}
