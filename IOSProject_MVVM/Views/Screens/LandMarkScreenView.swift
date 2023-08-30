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
//        NavigationView {
            VStack {

                SearchBarView(
                    textInput: $landMarkViewModel.textInputForLocation,
                    searchAction: {landMarkViewModel.fetchLandMarks()
                })

                switch landMarkViewModel.state {
                    case .success(let landmarks):
                    LandmarkListView(entities: landmarks, landMarkViewModel: landMarkViewModel)
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

                if case .success = landMarkViewModel.state { }
                else {
                    StaticLandMarkViews( landMarkViewModel: landMarkViewModel)
                }
            }
            .alert(isPresented: $landMarkViewModel.hasError) {
                errorAlert
            }
            .navigationBarBackButtonHidden()
            .navigationTitle("Welcome to Hotels")
            .navigationBarItems(trailing: LogoutButton )
            .navigationBarItems(leading: HomeButton )
//        }
    }
}

struct LandMarkScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LandMarkScreenView()
                    .environmentObject(LoginViewModel())
    }
}







