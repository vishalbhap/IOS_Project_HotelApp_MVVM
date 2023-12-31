//
//  ExtractedLandMarkViews.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 09/08/23.
//
import Foundation
import SwiftUI

// View for a search bar with a text input field and search button
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

// View for displaying a list of landmarks
struct LandmarkListView: View {
    var entities: [Entity]
    @EnvironmentObject var loginViewModel: LoginViewModel
    @ObservedObject var landMarkViewModel: LandmarkViewModel

    var body: some View {
        Text("Showing results for \(landMarkViewModel.textInputForLocation)")

        List(entities) { landmark in
            NavigationLink {
                HotelListScreenView(geoId: landmark.geoId)
                    .environmentObject(loginViewModel)
            } label: {
                Text(landmark.name)
                    .foregroundColor(Color.primary)
                    .padding(.vertical)
            }
        }
    }
}






