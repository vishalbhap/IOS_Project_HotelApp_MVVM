
//
//  ExtensionLandmarkScreen.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 30/08/23.
//

import Foundation
import SwiftUI

// extension Views
extension LandmarkScreenView {

    var LandmarkSearchBarView: some View {
        SearchBarView(
            textInput: $landMarkViewModel.textInputForLocation,
            searchAction: {landMarkViewModel.fetchLandMarks()
        })
    }

    var LandMarkListView: some View {
        LandmarkListView(entities: landMarkViewModel.entities, landMarkViewModel: landMarkViewModel)
                        .navigationBarTitle("Landmarks")
                        .environmentObject(loginViewModel)
    }

    var DataEmptyView: some View {
        Text("No Data Found for this location")
    }

    var LandmarkProgressView: some View {
        VStack{
            ProgressView()
            Text("Fetching landmarks...")
        }
    }

    var NoInputView: some View {
        Text("Enter some location")
    }

    var StaticlandmarkDataView: some View {
        StaticLandMarkViews( landMarkViewModel: landMarkViewModel)
    }

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
//            landMarkViewModel.textInputForLocation = ""
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

