//
//  LoginSubViews.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 25/08/23.
//

import Foundation
import SwiftUI

struct LoginScreenBackground: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color("PrimaryBlue"), Color("SecondaryTeal")]),
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

struct LoginTitle: View {
    var body: some View {
        VStack {
            SwiftUI.Image("SplashScreen")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.vertical) 

            Text("Login")
                .font(.system(size: 34, weight: .bold, design: .default))
                .foregroundColor(.blue)
        }
        .padding(.vertical) // Center content vertically
    }
}

struct EmailInputFieldView: View {
    @StateObject var loginViewModel: LoginViewModel

    var body: some View {
        VStack {
            HStack {
                SwiftUI.Image(systemName: "envelope")
                    .foregroundColor(.black)
                    .padding(.leading, 10) // Keep the same leading padding for both images

                TextField("Email", text: $loginViewModel.username)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.horizontal)
                    .onTapGesture {
                        loginViewModel.errorMessage = ""
                    }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1)
            )
        }
    }
}

struct PasswordInputFieldView: View {
    @StateObject var loginViewModel: LoginViewModel
    @State private var isPasswordVisible = false

    var body: some View {
        VStack {
            HStack {
                SwiftUI.Image(systemName: "lock")
                    .foregroundColor(.black)
                    .padding(.leading, 10) // Keep the same leading padding for both images

                if isPasswordVisible {
                    TextField("Password", text: $loginViewModel.password)
                        .onTapGesture {
                            loginViewModel.errorMessage = ""
                        }
                } else {
                    SecureField("Password", text: $loginViewModel.password)
                        .onTapGesture {
                            loginViewModel.errorMessage = ""
                        }
                }

                Button(action: {
                    isPasswordVisible.toggle()
                }) {
                    SwiftUI.Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1)
            )
        }
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
        Button(action: {
            Task {
                await loginViewModel.login()
            }
        }) {
            Text("Login")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue.opacity(0.8))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue, lineWidth: 2)
                )
                .padding([.horizontal, .bottom], 20)
        }
        .disabled(loginViewModel.isLoggedIn)
        .opacity(loginViewModel.isLoggedIn ? 0.6 : 1)
        .onTapGesture {
            withAnimation(.easeInOut) { 

            }
        }
    }
}

struct KeepSignedForgotPasswordView: View {
    @StateObject var loginViewModel: LoginViewModel

    var body: some View {
        HStack {
            Toggle("Keep me signed-in", isOn: $loginViewModel.keepSignedIn)
                .toggleStyle(RectangleCheckboxStyle())

            Text("Forgot Password?")
                .foregroundColor(.gray)
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
                            .opacity(configuration.isOn ? 1 : 0)
                    )

                configuration.label
            }
        }
    }
}

