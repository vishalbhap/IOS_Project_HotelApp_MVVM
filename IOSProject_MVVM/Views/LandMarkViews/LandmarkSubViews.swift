//
//  ExtractedLandMarkViews.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 09/08/23.
//

import Foundation
import SwiftUI


// Search Bar View with Button action
struct SearchBarView: View {
    @Binding var textInput: String
    var searchAction: () -> Void

    var body: some View {
        HStack {
            TextField("Enter location", text: $textInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                .shadow(color: Color.black.opacity(0.06), radius: 5, x: -5, y: -5)

            Button(action: searchAction) {
                SwiftUI.Image(systemName: "magnifyingglass")
                    .font(.title)
            }
            .padding()
        }

    }
}

// List View For Landmarks
struct LandmarkListView: View {
    var entities: [Entity]
    @EnvironmentObject var loginViewModel: LoginViewModel
    @ObservedObject var landMarkViewModel: LandMarkViewModel

    var body: some View {
        Text("Showing results for \(landMarkViewModel.placeName)")
        
        List(entities) { landmark in
            NavigationLink {
                HotelListScreenView(geoId: landmark.geoId)
                    .environmentObject(loginViewModel)
                    
            } label: {
                Text(landmark.name)
                    .foregroundColor(.blue)
                    .padding(.vertical)
            }
        }
    }
}


extension LandMarkScreenView {

    var errorAlert: Alert {
        Alert(
            title: Text("Error"),
            message: Text(landMarkViewModel.state.localizedDescription),
            primaryButton: .default(Text("Retry"), action: landMarkViewModel.fetchLandMarks),
            secondaryButton: .cancel(Text("Cancel"))
        )
    }


    var HomeButton: some View {
        Button(action: {
            landMarkViewModel.state = .none
        }) {
            SwiftUI.Image(systemName: "house.fill") // Use your back arrow icon here
                .foregroundColor(.blue) // Adjust color as needed
                .imageScale(.large)
        }
    }

    var LogoutButton: some View {
        Button(action: {
            landMarkViewModel.logout()
            loginViewModel.isLoggedIn = false
        }) {
            Text("Logout")
                .foregroundColor(.red)
        }
    }
}




