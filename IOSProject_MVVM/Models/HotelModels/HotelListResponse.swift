//
//  AllHotelData.swift
//  SwiftUI_HotelApp
//
//  Created by Vishal Bhapkar on 31/07/23.
//

import Foundation

struct HotelListResponse : Codable {
    let data : Data?

    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

struct Data : Codable {
    let propertySearch : PropertySearch?

    enum CodingKeys: String, CodingKey {
        case propertySearch = "propertySearch"
    }
}

struct PropertySearch : Codable {
    let properties : [Properties]?

    enum CodingKeys: String, CodingKey {
        case properties = "properties"
    }
}


