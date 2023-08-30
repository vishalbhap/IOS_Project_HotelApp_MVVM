//
//  LoginViewModel.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 25/08/23.
//

import Foundation
import SwiftUI

@MainActor
class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var isLoggedIn = false
    @Published var keepSignedIn = false
    
    private let loginService = LoginService()




    // Calling service functionality
    func login() async {
        guard validateInput() else {
            return
        }
        
        do {
            let loginResponseArray = try await loginService.login(username: username, password: password)
            try authenticateUser(loginModelArray: loginResponseArray)
            errorMessage = ""
            isLoggedIn = true
        } catch {
            handleLoginError(error)
        }
    }



    

    // validate all input validations
    func validateInput() -> Bool {
        guard !username.isEmpty else {
            errorMessage = "Username is required"
            return false
        }

        guard !password.isEmpty else {
            errorMessage = "Password is required"
            return false
        }

        if !isValidEmail(username) {
            errorMessage = "Invalid email format"
            return false
        }

        if !isValidPassword(password) {
            errorMessage = "Password must be at least 6 characters long and contain letters, digits, and special characters"
            return false
        }

        return true
    }


    // authenticate credentials to login successfully
    func authenticateUser(loginModelArray: [LoginModel]) throws {
        guard username == loginModelArray[0].email && password == loginModelArray[0].password else {
            throw LoginError.invalidCredentials
        }
        clearCredentials()
    }

    func handleLoginError(_ error: Error) {
        if let apiError = error as? LoginError {
            errorMessage = apiError.localizedDescription
        } else {
            errorMessage = "An error occurred"
        }
        isLoggedIn = false
    }


    func clearCredentials() {
        username = ""
        password = ""
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Za-z0-9+_.-]+@(.+)$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{6,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }

    func validateEmail(){
        guard isValidEmail(username) else {
            errorMessage = "Invalid email format"
            return
        }
    }

    func validatePassword(){
        guard isValidPassword(password) else {
            errorMessage = "Password must be at least 6 characters long and contain letters, digits, and special characters"
            return
        }
    }
}
