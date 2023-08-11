//
//  LandMarkService.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 08/08/23.
//

import Foundation


class LandMarkService {

    func fetchLandMarksData(location: String) async throws -> LandMarkModelResponse {
        guard let url = URL(string: "https://hotels4.p.rapidapi.com/locations/v2/search?query=\(location)") else {
            throw LandMarkServiceError.invalidURL
        }
        let request = CommonServiceData().configureRequest(url: url, httpMethod: "GET")
        let (data, response) = try await URLSession.shared.data(for: request)

        // For developers error handling
        try CommonServiceData().checkForCommonResponseErrors(response: response as! HTTPURLResponse)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            throw LandMarkServiceError.serverError
        }
        do {
                let decodedData = try JSONDecoder().decode(LandMarkModelResponse.self, from: data)
                return decodedData
            } catch {
                throw LandMarkServiceError.invalidData
            }
    }
    
}

