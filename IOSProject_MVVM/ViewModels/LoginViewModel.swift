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

    // Published properties that trigger UI updates when their values change.
    @Published var username = "john@gmail.com"
    @Published var password = "Cybage@123"
    @Published var errorMessage = ""
    @Published var isLoggedIn = false
    @Published var keepSignedIn = false

    private let loginService: LoginService

    // Initialize the view model with a service conforming to LoginService.
    init(loginService: LoginService) {
        self.loginService = loginService
    }

    // Computed property to check if the app is in dark mode.
    var isDarkMode: Bool {
        UIScreen.main.traitCollection.userInterfaceStyle == .dark
    }

    // Function to perform the login action.
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

    // Function to validate user input.
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

    // Function to authenticate the user.
    func authenticateUser(loginModelArray: [LoginModel]) throws {
        guard username == loginModelArray[0].email && password == loginModelArray[0].password else {
            throw LoginError.invalidCredentials
        }
        clearCredentials()
    }

    // Function to handle login errors.
    func handleLoginError(_ error: Error) {
        if let apiError = error as? LoginError {
            errorMessage = apiError.localizedDescription
        } else {
            errorMessage = "An error occurred"
        }
        isLoggedIn = false
    }

    // Function to clear user credentials.
    func clearCredentials() {
        username = ""
        password = ""
    }

    // Function to validate email format.
    func validateEmail(){
        guard isValidEmail(username) else {
            errorMessage = "Invalid email format"
            return
        }
    }

    // Function to validate password format.
    func validatePassword(){
        guard isValidPassword(password) else {
            errorMessage = "Password must be at least 6 characters long and contain letters, digits, and special characters"
            return
        }
    }

    // Function to validate if an email is in the correct format.
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Za-z0-9+_.-]+@(.+)$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    // Function to validate if a password meets the criteria.
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{6,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
}
