//
//  Properties.swift
//  SwiftUI_HotelApp
//
//  Created by Vishal Bhapkar on 31/07/23.
//

import Foundation

struct Properties : Codable, Identifiable{
    let id : String
    let name : String
    let propertyImage : PropertyImage
    let destinationInfo : DestinationInfo
    let mapMarker : MapMarker
    let price : Price
    let reviews : Reviews?
    let star : String?
    let regionId : String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case propertyImage = "propertyImage"
        case destinationInfo = "destinationInfo"
        case mapMarker = "mapMarker"
     
        case price = "price"
        case reviews = "reviews"
        case star = "star"
        case regionId = "regionId"
        
    } 

}
