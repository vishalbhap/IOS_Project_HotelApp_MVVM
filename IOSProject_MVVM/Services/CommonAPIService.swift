//
//  CommonServiceData.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 08/08/23.
//

import Foundation

struct APIConfig {
    static let apiKey = "dc1985c65dmsh246f7af80a714d1p126255jsn72836cf8354b"
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

    func checkForCommonResponseErrors(response: HTTPURLResponse) throws {
        if response.statusCode == 403 {
            throw CommonError.invalidKey
        }
        if response.statusCode == 404 {
            throw CommonError.invalidURLRequest
        }
        if response.statusCode == 429 {
            throw CommonError.requestQuotaFull
        }
    }
    
}


