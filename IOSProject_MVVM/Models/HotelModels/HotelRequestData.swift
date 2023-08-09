//
//  RequestData.swift
//  SwiftUI_HotelApp
//
//  Created by Vishal Bhapkar on 31/07/23.
//

import Foundation

struct HotelRequestData: Codable {
    let currency: String
    let eapid: Int
    let locale: String
    let siteId: Int
    let destination: Destination
    let checkInDate: DateInfo
    let checkOutDate: DateInfo
    let rooms: [Room]
    let resultsStartingIndex: Int
    let resultsSize: Int
    let sort: String
    let filters: Filters
}

struct Destination: Codable {
    let regionId: String
}

struct DateInfo: Codable {
    let day: Int
    let month: Int
    let year: Int
}

struct Room: Codable {
    let adults: Int
    let children: [Child]
}

struct Child: Codable {
    let age: Int
}

struct Filters: Codable {
    let price: PriceFilter
}

struct PriceFilter: Codable {
    let max: Int
    let min: Int
}
