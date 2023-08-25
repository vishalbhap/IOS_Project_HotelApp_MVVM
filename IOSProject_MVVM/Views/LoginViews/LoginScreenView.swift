//
//  LoginScreenView.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 25/08/23.
//

import SwiftUI
import Combine

struct LoginScreenView: View {
    @StateObject private var loginViewModel: LoginViewModel = LoginViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                LoginScreenBackground()

                VStack {
                    LoginTitle()

                    EmailInputFieldView(loginViewModel: loginViewModel)

                    PasswordInputFieldView(loginViewModel: loginViewModel)

                    ErrorMessageView(loginViewModel: loginViewModel)

                    KeepSignedForgotPasswordView(loginViewModel: loginViewModel)

                    LoginButtonView(loginViewModel: loginViewModel)

                    NavigationLink(
                        destination: LandMarkScreenView(),
                        isActive: $loginViewModel.isLoggedIn,
                        label: { EmptyView() }
                    )
                    .hidden()
                }
                .padding()
            }
        }
    }
}


struct LoginScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreenView()
    }
}





