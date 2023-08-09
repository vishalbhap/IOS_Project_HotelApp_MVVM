//
//  Price.swift
//  SwiftUI_HotelApp
//
//  Created by Vishal Bhapkar on 31/07/23.
//

import Foundation

struct Price : Codable {
    
    let options : [Options]
    enum CodingKeys: String, CodingKey {
        case options = "options"
    }
}

struct Options : Codable {

    let strikeOut : StrikeOut?
    let formattedDisplayPrice : String

    enum CodingKeys: String, CodingKey {
        case strikeOut = "strikeOut"
        case formattedDisplayPrice = "formattedDisplayPrice"
    }
}

struct StrikeOut : Codable {
    let formatted : String?

    enum CodingKeys: String, CodingKey {
        case formatted = "formatted"
    }
}
