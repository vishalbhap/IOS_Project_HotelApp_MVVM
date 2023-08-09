//
//  LandMarkService.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 08/08/23.
//

import Foundation


class LandMarkService {

    func fetchCities(country: String) async throws -> LandMarkModelResponse {
        guard let url = URL(string: "https://hotels4.p.rapidapi.com/locations/v2/search?query=\(country)") else {
            throw SomeError.invalidURL
        }

        let request = CommonServiceData().configureRequest(url: url, httpMethod: "GET")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedData = try JSONDecoder().decode(LandMarkModelResponse.self, from: data)
            return decodedData
        } catch {
            throw SomeError.networkError(error)
        }
    }   

    
}
