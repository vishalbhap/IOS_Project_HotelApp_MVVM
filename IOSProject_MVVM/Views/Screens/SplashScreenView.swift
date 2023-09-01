//
//  SplashScreenView.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 28/08/23.
//

import SwiftUI

struct SplashView: View {
    @State private var isSplashOver = false

    var body: some View {

        ZStack {
//            LoginBackgroundView
            Color.yellow.ignoresSafeArea()
            VStack {
                SwiftUI.Image("SplashScreen") // Replace with your logo image name
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 250)

                Text("Welcome to Atlas Hotels")
                    .font(.headline)
                    .foregroundColor(.primary)

                Text("Your favourite place to book hotel online ends here")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.top, 5)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isSplashOver = true
                    }
                }
            }
            .fullScreenCover(isPresented: $isSplashOver) {
                NavigationView {
                    LoginScreenView()
                }
        }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}

