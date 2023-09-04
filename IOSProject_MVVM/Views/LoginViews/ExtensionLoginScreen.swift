//
//  ExtensionLoginScreen.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 30/08/23.
//

import Foundation
import SwiftUI

// Extension of LoginScreenView for creating subviews.
extension LoginScreenView {

    // View for the login screen background (You can replace LoginScreenBackground with your own)
    var LoginBackgroundView: some View {
        LoginScreenBackground()
    }

    // View for the login screen title (You can replace LoginTitle with your own)
    var LoginTitleView: some View {
       LoginTitle()
    }

    // View for the email input field (You can replace EmailInputFieldView with your own)
    var EmailTextInputFieldView: some View {
        EmailInputFieldView(loginViewModel: loginViewModel)
            .padding(.bottom)
    }

    // View for the password input field (You can replace PasswordInputFieldView with your own)
    var PasswordTextInputFieldView: some View {
        PasswordInputFieldView(loginViewModel: loginViewModel)
    }

    // View for displaying error messages (You can replace ErrorMessageView with your own)
    var ErrorMessageFieldView: some View {
        ErrorMessageView(loginViewModel: loginViewModel)
    }

    // View for keeping signed in and forgot password options (You can replace KeepSignedForgotPasswordView with your own)
    var KeepSignedForgotPasswordFieldView: some View {
        KeepSignedForgotPasswordView(loginViewModel: loginViewModel)
    }

    // View for the login button (You can replace LoginButtonView with your own)
    var LoginButtonFieldView: some View {
        LoginButtonView(loginViewModel: loginViewModel)
    }
}
