//
//  LandMarkModel.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 08/08/23.
//

import Foundation


import Foundation

struct LandMarkModelResponse : Codable {
    let suggestions : [Suggestion]

    enum CodingKeys: String, CodingKey {
        case suggestions = "suggestions"
    }
}


struct Suggestion : Codable  {
    let group : String
    let entities : [Entity]

    enum CodingKeys: String, CodingKey {
        case group = "group"
        case entities = "entities"
    }
}


struct Entity : Codable, Identifiable, Equatable {
    let geoId : String
    let destinationId : String
    let latitude : Double
    let longitude : Double
    let name : String

    var id = UUID()

    enum CodingKeys: String, CodingKey {
        case geoId = "geoId"
        case destinationId = "destinationId"
        case latitude = "latitude"
        case longitude = "longitude"
        case name = "name"
    }
}
