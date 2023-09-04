
//
//  ExtensionLandmarkScreen.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 30/08/23.
//

import Foundation
import SwiftUI

// Extension for subviews in the LandmarkScreenView
extension LandmarkScreenView {

    // View for the landmark search bar
    var LandmarkSearchBarView: some View {
        SearchBarView(
            textInput: $landMarkViewModel.textInputForLocation,
            searchAction: { landMarkViewModel.fetchLandMarks() }
        )
    }

    // View for displaying the list of landmarks
    var LandMarkListView: some View {
        LandmarkListView(entities: landMarkViewModel.entities, landMarkViewModel: landMarkViewModel)
            .navigationBarTitle("Landmarks")
            .environmentObject(loginViewModel)
    }

    // View for displaying a message when no data is found
    var DataEmptyView: some View {
        Text("No Data Found for this location")
    }

    // View for displaying a progress indicator while fetching landmarks
    var LandmarkProgressView: some View {
        VStack {
            ProgressView()
            Text("Fetching landmarks...")
        }
    }

    // View for displaying a message when no input is provided
    var NoInputView: some View {
        Text("Enter some location")
    }

    // View for displaying static landmark data
    var StaticlandmarkDataView: some View {
        StaticLandMarkViews(landMarkViewModel: landMarkViewModel)
    }

    // Alert view for displaying errors
    var errorAlert: Alert {
        Alert(
            title: Text("Error"),
            message: Text(landMarkViewModel.state.localizedDescription),
            primaryButton: .default(Text("Retry"), action: landMarkViewModel.fetchLandMarks),
            secondaryButton: .cancel(Text("Cancel"))
        )
    }

    // View for the home button
    var HomeButton: some View {
        Button(action: {
            landMarkViewModel.textInputForLocation = ""
            landMarkViewModel.state = .none
        }) {
            SwiftUI.Image(systemName: "house.fill") // Use your back arrow icon here
                .foregroundColor(.blue) // Adjust color as needed
                .imageScale(.large)
        }
    }

    // View for the logout button
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


