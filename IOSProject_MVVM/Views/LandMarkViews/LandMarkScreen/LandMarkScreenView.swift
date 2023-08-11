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

    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(textInput: $landMarkViewModel.textInputForLocation, searchAction: {
                    landMarkViewModel.fetchLandMarks()
                })

                switch landMarkViewModel.state {
                    case .success(let landmarks):
                            LandmarkListView(entities: landmarks)
                                .navigationBarTitle("Landmarks")

                    case .dataEmpty:
                        Text("No Data Found for this location")

                    case .loading:
                        ProgressView()

                    case .noTextInput:
                        Text("Enter some location")

                    default:
                        EmptyView()
                    }

                    if case .success = landMarkViewModel.state { } else { StaticLandMarkViews() }
            }
            .alert("Error", isPresented: $landMarkViewModel.hasError, presenting: landMarkViewModel.state) { detail in
                Button("Retry") {landMarkViewModel.fetchLandMarks()}
                Button("Cancel", role: .cancel) {}
            } message: { detail in
                if case let .failed(error) = detail {
                    Text(error.localizedDescription)
                }
            }
        }
    }
}

struct LandMarkScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LandMarkScreenView()
    }
}

