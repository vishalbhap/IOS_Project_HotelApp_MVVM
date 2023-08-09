//
//  PropertyImage.swift
//  SwiftUI_HotelApp
//
//  Created by Vishal Bhapkar on 31/07/23.
//

import Foundation

struct PropertyImage : Codable {
    let image : Image

    enum CodingKeys: String, CodingKey {
        case image = "image"
    }
}

struct Image : Codable {
    let description : String
    let url : String

    enum CodingKeys: String, CodingKey {
        case description = "description"
        case url = "url"
    }
}


