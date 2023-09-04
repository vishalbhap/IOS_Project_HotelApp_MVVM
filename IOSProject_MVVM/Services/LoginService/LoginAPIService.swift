//
//  LoginService.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 25/08/23.
//

import Foundation

// Protocol defining the interface for a LoginService.
protocol LoginService {
    func login(username: String, password: String) async throws -> [LoginModel]
}

// Implementation of LoginService using a real API.
class LoginAPIService: LoginService {
    func login(username: String, password: String) async throws -> [LoginModel] {
        guard let url = URL(string: "http://172.27.46.174:3000/login") else {
            throw LoginError.invalidURL
        }
        // Creating a request object with common headers.
        let request = CommonDataService().configureRequest(url: url, httpMethod: "GET")
        let (data, response) = try await URLSession.shared.data(for: request)

        // Checking for common errors in the HTTP response.
        try CommonDataService().checkForCommonResponseErrors(response: response as! HTTPURLResponse)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw LoginError.serverError
        }
        do {
            let decodedData = try JSONDecoder().decode(LoginModelResponse.self, from: data)
            let loginModelArray = decodedData.logins
            return loginModelArray
        } catch {
            throw LoginError.invalidData
        }
    }
}

// Mock implementation of LoginService for testing purposes.
class LoginMockService: LoginService {
    func login(username: String, password: String) async throws -> [LoginModel] {
        let loginModels = [
            LoginModel(email: "john@gmail.com", password: "Cybage@123")
        ]
        return loginModels
    }
}
