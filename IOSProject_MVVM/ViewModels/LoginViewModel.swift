//
//  LoginViewModel.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 25/08/23.
//

import Foundation
import SwiftUI


class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var isLoggedIn = false
    @Published var keepSignedIn = false

    private let loginService = LoginService()

    func login() async {
        // Basic input validation
        guard !username.isEmpty else {
            errorMessage = "Username is required"
            return
        }

        guard !password.isEmpty else {
            errorMessage = "Password is required"
            return
        }

        if !isValidEmail(username) {
            errorMessage = "Invalid email format"
            return
        }

        if !isValidPassword(password) {
            errorMessage = "Password must be at least 6 characters long and contain letters, digits, and special characters"
            return
        }

        do {
            let loginResponseArray = try await loginService.login(username: username, password: password)
            try authenticateUser(loginModelArray: loginResponseArray)
            errorMessage = ""
            isLoggedIn = true
        } catch {
            print("Error occured")
            if let apiError = error as? LoginError {
                errorMessage = apiError.localizedDescription
            } else {
                errorMessage = "An error occurred"
            }
            isLoggedIn = false
        }
    }

    func authenticateUser(loginModelArray: [LoginModel]) throws {
        if username == loginModelArray[0].email && password == loginModelArray[0].password {
            username = ""
            password = ""
            return
        } else {
            throw LoginError.invalidCredentials
        }
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
