//
//  LandMarkScreenView.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 08/08/23.
//

import Foundation
import SwiftUI

struct LandMarkScreenView: View {
    @ObservedObject var landMarkViewModel: LandMarkViewModel = LandMarkViewModel()
    @EnvironmentObject var loginViewModel: LoginViewModel

    var body: some View {
        NavigationView {
            VStack {

                SearchBarView(
                    textInput: $landMarkViewModel.textInputForLocation,
                    searchAction: {landMarkViewModel.fetchLandMarks()
                })

                switch landMarkViewModel.state {
                    case .success(let landmarks):
                    Text("Showing results for \(landMarkViewModel.placeName)")

                        LandmarkListView(entities: landmarks)
                                    .navigationBarTitle("Landmarks")
                                    .environmentObject(loginViewModel)

                    case .dataEmpty:
                        Text("No Data Found for this location")

                    case .loading:
                        ProgressView()
                        Text("Fetching lamdmarks...")

                    case .noTextInput:
                        Text("Enter some location")

                    default:
                        EmptyView()
                    }

                if case .success = landMarkViewModel.state { } else { StaticLandMarkViews( landMarkViewModel: landMarkViewModel) }

            }
            .alert("Error", isPresented: $landMarkViewModel.hasError, presenting: landMarkViewModel.state) { detail in
                Button("Retry") {landMarkViewModel.fetchLandMarks()}
                Button("Cancel", role: .cancel) {}
            } message: { detail in
                if case let .failed(error) = detail {
                    Text(error.localizedDescription)
                }
            }
            .navigationBarBackButtonHidden()
            .navigationTitle("Welcome to Hotels")
            .navigationBarItems(trailing:
                    Button(action: {
                        landMarkViewModel.logout()
                        loginViewModel.isLoggedIn = false
                    }) {
                        Text("Logout")
                            .foregroundColor(.red)
                    }
                )
            .navigationBarItems(leading:
                Button(action: {
                    landMarkViewModel.state = .none
                }) {
                    SwiftUI.Image(systemName: "house.fill") // Use your back arrow icon here
                        .foregroundColor(.blue) // Adjust color as needed
                        .imageScale(.large)
                }
            )
        }
    }
}

struct LandMarkScreenView_Previews: PreviewProvider {
    static var previews: some View {
//        LandMarkScreenView()
        LandMarkScreenView()
                    .environmentObject(LoginViewModel())
    }
}

