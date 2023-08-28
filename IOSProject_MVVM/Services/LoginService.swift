//
//  LoginService.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 25/08/23.
//

import Foundation

class LoginService {
    func login(username: String, password: String) async throws -> [LoginModel] {
        guard let url = URL(string: "http://localhost:3000/login") else {
           throw LoginError.invalidURL
       }
       let request = CommonServiceData().configureRequest(url: url, httpMethod: "GET")

       let (data, response) = try await URLSession.shared.data(for: request)

       try CommonServiceData().checkForCommonResponseErrors(response: response as! HTTPURLResponse)

       guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
           throw LoginError.serverError
       }

       do {
           let decodedData = try JSONDecoder().decode(LoginsModel.self, from: data)
           let loginDataResponse = decodedData.logins
           return loginDataResponse
       } catch {
           throw LoginError.invalidData
       }
    }

    func authenticateUser(){

    }
}
