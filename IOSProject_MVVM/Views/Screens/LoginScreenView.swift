//
//  LoginScreenView.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 25/08/23.
//

import SwiftUI

// A view for the login screen.
struct LoginScreenView: View {
    @StateObject var loginViewModel: LoginViewModel = LoginViewModel(loginService: LoginAPIService())

    var body: some View {
        NavigationStack {
            ZStack {
                // Background view for the login screen (You can replace LoginBackgroundView with your own)
                LoginBackgroundView

                VStack {
                    // Title of the login screen
                    LoginTitleView

                    // Email input field
                    EmailTextInputFieldView

                    // Password input field
                    PasswordTextInputFieldView

                    // Display error messages
                    ErrorMessageFieldView

                    // Keep signed in and forgot password options
                    KeepSignedForgotPasswordFieldView

                    // Login button
                    LoginButtonFieldView
                }
                .padding()

                // Navigate to LandmarkScreenView when isLoggedIn becomes true
                .navigationDestination(isPresented: $loginViewModel.isLoggedIn) {
                    LandmarkScreenView()
                        .environmentObject(loginViewModel)
                }
            }
        }
    }
}

// Preview for the LoginScreenView.
struct LoginScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreenView()
    }
}






