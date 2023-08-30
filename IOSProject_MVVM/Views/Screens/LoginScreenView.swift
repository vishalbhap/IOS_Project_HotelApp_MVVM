//
//  LoginScreenView.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 25/08/23.
//

import SwiftUI

struct LoginScreenView: View {
    @StateObject var loginViewModel: LoginViewModel = LoginViewModel()    

    var body: some View {
        NavigationStack {
            ZStack {
                LoginBackgroundView

                VStack {
                        LoginTitleView

                        EmailTextInputFieldView

                        PasswordTextInputFieldView

                        ErrorMessageFieldView

                        KeepSignedForgotPasswordFieldView

                        LoginButtonFieldView
            }
            .padding()
            .navigationDestination(isPresented: $loginViewModel.isLoggedIn) {
                    LandMarkScreenView()
                        .environmentObject(loginViewModel)
                }
            }
        }        
    }
}

struct LoginScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreenView()
    }
}





