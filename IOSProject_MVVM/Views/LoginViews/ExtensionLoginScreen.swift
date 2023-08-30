//
//  ExtensionLoginScreen.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 30/08/23.
//

import Foundation
import SwiftUI

extension LoginScreenView {

    var LoginBackgroundView: some View {
        LoginScreenBackground()
    }

    var LoginTitleView: some View {
       LoginTitle()
    }

    var EmailTextInputFieldView: some View {
        EmailInputFieldView(loginViewModel: loginViewModel)
            .padding(.bottom)
    }

    var PasswordTextInputFieldView: some View {
        PasswordInputFieldView(loginViewModel: loginViewModel)
    }

    var ErrorMessageFieldView: some View {
        ErrorMessageView(loginViewModel: loginViewModel)
    }

    var KeepSignedForgotPasswordFieldView: some View {
        KeepSignedForgotPasswordView(loginViewModel: loginViewModel)
    }

    var LoginButtonFieldView: some View {
        LoginButtonView(loginViewModel: loginViewModel)
    }
}
