//
//  SplashScreenView.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 28/08/23.
//

import SwiftUI

// A view for displaying a splash screen.
struct SplashView: View {
    @State private var isSplashOver = false

    var body: some View {

        ZStack {
            // Background color (You can replace this with your own background view)
            Color.purple.opacity(0.5).ignoresSafeArea()

            VStack {
                // Logo or image (Replace "SplashScreen" with your logo image name)
                SwiftUI.Image("SplashScreen")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 250)

                // App title
                Text("Welcome to Atlas Hotels")
                    .font(.headline)
                    .foregroundColor(.primary)

                // App description
                Text("Your favorite place to book hotels online ends here")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.top, 5)
            }
            .onAppear {
                // Automatically dismiss the splash screen after 2 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isSplashOver = true // Splash complete
                    }
                }
            }
            // Transition to the main screen when the splash is over
            .fullScreenCover(isPresented: $isSplashOver) {
                NavigationView {
                    LoginScreenView() // Replace with your main screen view
                }
            }
        }
    }
}

// Preview for the SplashView.
struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
