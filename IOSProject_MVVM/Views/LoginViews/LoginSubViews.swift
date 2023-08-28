//
//  LoginSubViews.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 25/08/23.
//

import Foundation
import SwiftUI

struct LoginTitle: View {
    var body: some View {
        Text("Login")
            .font(.largeTitle)
            .bold()
            .padding()
    }
}


struct EmailInputFieldView: View {
    @StateObject var loginViewModel: LoginViewModel

    var body: some View {
        TextField("Username", text: $loginViewModel.username)
            .padding()
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .onTapGesture {
                loginViewModel.errorMessage = ""
            }
            .overlay(
                HStack {
                    SwiftUI.Image(systemName: "person")
                        .foregroundColor(.black)
                        .padding(.leading, -5)
                    Spacer()
                }
            )
    }
}

struct PasswordInputFieldView: View {
    @StateObject var loginViewModel: LoginViewModel

    var body: some View {
        SecureField("Password", text: $loginViewModel.password)
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .onTapGesture {
                loginViewModel.errorMessage = ""
            }
            .overlay(
                HStack {
                    SwiftUI.Image(systemName: "lock")
                        .foregroundColor(.black)
                        .padding(.leading, -5)
                    Spacer()
                }
            )
    }
}

struct ErrorMessageView: View {
    @StateObject var loginViewModel: LoginViewModel

    var body: some View {
        Text(loginViewModel.errorMessage)
            .foregroundColor(.red)
            .padding()
    }
}

struct LoginButtonView: View {
    @StateObject var loginViewModel: LoginViewModel

    var body: some View {
        Button("Login") {
            Task {
                await loginViewModel.login()
            }
        }
        .padding()
        .frame(width: 200, height: 40)
        .foregroundColor(.white)
        .background(.blue)
        .cornerRadius(10)
        .padding(20)
        .transition(AnyTransition.opacity.animation(.easeIn))
        .disabled(loginViewModel.isLoggedIn)
    }
}

struct KeepSignedForgotPasswordView: View {
    @StateObject var loginViewModel: LoginViewModel

    var body: some View {
        HStack {
            Toggle("Keep me signed-in", isOn: $loginViewModel.keepSignedIn)
                .toggleStyle(RectangleCheckboxStyle())

            Text("Forgot Password?")
        }
    }
}

struct RectangleCheckboxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: { configuration.isOn.toggle() }) {
            HStack {
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: 18, height: 18)
                    .foregroundColor(configuration.isOn ? Color.blue : Color.gray)
                    .overlay(
                        SwiftUI.Image(systemName: "checkmark")
                            .foregroundColor(.white)
                            .font(.system(size: 12, weight: .bold))
                            .opacity(configuration.isOn ? 1 : 0) // Show/hide the checkmark
                    )

                configuration.label
            }
        }
    }
}

