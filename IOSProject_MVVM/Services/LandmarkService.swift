//
//  LandMarkService.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 08/08/23.
//

import Foundation

protocol LandmarkServiceProtocol {
//        func fetchItems() async throws -> [Item]
}


class LandmarkService {

    func fetchLandMarksData(location: String) async throws -> LandmarkModelResponse {
        guard let url = URL(string: "https://hotels4.p.rapidapi.com/locations/v2/search?query=\(location)") else {
            throw LandmarkServiceError.invalidURL
        }
        let request = CommonDataService().configureRequest(url: url, httpMethod: "GET")
        let (data, response) = try await URLSession.shared.data(for: request)

        // For developers error handling
        try CommonDataService().checkForCommonResponseErrors(response: response as! HTTPURLResponse)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            throw LandmarkServiceError.serverError
        }
        do {
                let decodedData = try JSONDecoder().decode(LandmarkModelResponse.self, from: data)
                return decodedData
            } catch {
                throw LandmarkServiceError.invalidData
            }
    }
    
}

