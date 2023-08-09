//
//  DesinationInfo.swift
//  SwiftUI_HotelApp
//
//  Created by Vishal Bhapkar on 31/07/23.
//

import Foundation

struct DestinationInfo : Codable {
    let distanceFromDestination : DistanceFromDestination
    let regionId : String

    enum CodingKeys: String, CodingKey {
        case distanceFromDestination = "distanceFromDestination"
        case regionId = "regionId"
    }
}

struct DistanceFromDestination : Codable {
    let unit : String
    let value : Double

    enum CodingKeys: String, CodingKey {
        case unit = "unit"
        case value = "value"
    }
}
