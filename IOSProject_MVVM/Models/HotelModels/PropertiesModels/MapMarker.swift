//
//  MapMarker.swift
//  SwiftUI_HotelApp
//
//  Created by Vishal Bhapkar on 31/07/23.
//

import Foundation

struct MapMarker : Codable {
    let __typename : String
    let label : String
    let latLong : LatLong

    enum CodingKeys: String, CodingKey {

        case __typename = "__typename"
        case label = "label"
        case latLong = "latLong"
    }
}

struct LatLong : Codable {
    let __typename : String
    let latitude : Double
    let longitude : Double

    enum CodingKeys: String, CodingKey {

        case __typename = "__typename"
        case latitude = "latitude"
        case longitude = "longitude"
    }
}
