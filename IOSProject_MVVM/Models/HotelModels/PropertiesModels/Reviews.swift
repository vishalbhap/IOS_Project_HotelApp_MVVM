//
//  Reviews.swift
//  SwiftUI_HotelApp
//
//  Created by Vishal Bhapkar on 02/08/23.
//

import Foundation

struct Reviews : Codable {
    let score : Double?
    let total : Int

    enum CodingKeys: String, CodingKey {
        case score = "score"
        case total = "total"
    }
}
