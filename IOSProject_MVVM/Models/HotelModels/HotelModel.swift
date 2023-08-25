//
//  Results.swift
//  SwiftUI_HotelApp
//
//  Created by Vishal Bhapkar on 01/08/23.
//


import Foundation

struct HotelListModel: Decodable {
    let hoteldetails: [HotelModel]
}

struct HotelModel: Codable, Identifiable{
   enum CodingKeys: CodingKey {
       case name
       case address
       case price
       case strikeouprice
       case ratingcount
       case star
       case imageUrl
       case destination
    }

    var id = UUID()
    var name, address, price, strikeouprice: String
    var ratingcount: Int
    var star: Double
    var destination: Double
    var imageUrl: String
}
