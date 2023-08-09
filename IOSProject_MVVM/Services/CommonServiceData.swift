//
//  CommonServiceData.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 08/08/23.
//

import Foundation

struct APIConfig {
    static let apiKey = "a5dc511090mshe2f6e52f07d26aep1f378fjsncf83e7ea63c9"
    static let host = "hotels4.p.rapidapi.com"
}

class CommonServiceData {

    func configureRequest(url: URL, httpMethod: String) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(APIConfig.apiKey, forHTTPHeaderField: "x-rapidapi-key")
        request.setValue(APIConfig.host, forHTTPHeaderField: "x-rapidapi-host")
        return request
    }
}

enum SomeError: Error {
    case invalidURL
    case decodingError
    case networkError(Error)
}




