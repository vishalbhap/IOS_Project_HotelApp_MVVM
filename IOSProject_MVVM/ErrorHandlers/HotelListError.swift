//
//  HotelListError.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 16/08/23.
//

import Foundation

enum HotelListServiceError: Error, LocalizedError {
    case invalidURL
    case encodingFailed
    case serverError
    case invalidData
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL was invalid, please try again"
        case .encodingFailed:
            return "Failed to encode request data to JSON"
        case .serverError:
            return "There was an error with the server. Please try again later"
        case .invalidData:
            return "Failed to Decode. The landmark data is invalid."
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
