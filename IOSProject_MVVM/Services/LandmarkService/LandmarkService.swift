//
//  LandMarkService.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 08/08/23.
//

import Foundation

protocol LandmarkServiceProtocol {
    func fetchLandMarksData(location: String) async throws -> LandmarkModelResponse
}


class LandmarkAPIService: LandmarkServiceProtocol {
    func fetchLandMarksData(location: String) async throws -> LandmarkModelResponse {
        let urlString = APIConfig.baseUrl.appending("locations/v2/search?query=\(location)")
        guard let url = URL(string: urlString) else {
            throw LandmarkServiceError.invalidURL
        }
        let request = CommonDataService().configureRequest(url: url, httpMethod: "GET")
        let (data, response) = try await APIConfig.urlSession.data(for: request)
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


class LandmarkMockService: LandmarkServiceProtocol {
    func fetchLandMarksData(location: String) async throws -> LandmarkModelResponse {
        let entities: [Entity] = [
            Entity(geoId: "1598", destinationId: "1", latitude: 123456, longitude: 12345, name: "Pune"),
            Entity(geoId: "1528", destinationId: "1", latitude: 123456, longitude: 12345, name: "Mumbai"),
            Entity(geoId: "8188", destinationId: "1", latitude: 123456, longitude: 12345, name: "Nashik"),
            Entity(geoId: "10770", destinationId: "1", latitude: 123456, longitude: 12345, name: "Indian Shores"),
            Entity(geoId: "7868", destinationId: "1", latitude: 123456, longitude: 12345, name: "Indiana")
        ]
        let suggestion: [Suggestion] = [ Suggestion(group: "CITY_GROUP", entities: entities) ]
        let landmarkModelResponse = LandmarkModelResponse(term: "india", suggestions: suggestion)
        return landmarkModelResponse
    }
}

