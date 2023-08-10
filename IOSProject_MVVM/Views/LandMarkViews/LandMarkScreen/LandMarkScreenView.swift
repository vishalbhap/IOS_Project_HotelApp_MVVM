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
                    case .success(let entities):
                        if entities.isEmpty{
                            Text("No Data Found for this location")
                            StaticLandMarkViews()
                        }else{
                            LandmarkListView(entities: entities)
                                .navigationBarTitle("Landmarks")
                        }
                    case .loading:
                        ProgressView()
                        StaticLandMarkViews()
                    case .noInput:
                        Text("Enter some location")
                        StaticLandMarkViews()
                    default:
                        StaticLandMarkViews()
                    }
                
            }
            .alert("Error",
                   isPresented: $landMarkViewModel.hasError,
                   presenting: landMarkViewModel.state) { detail in
                Button("Retry") {
                    landMarkViewModel.fetchLandMarks()
                }
                Button("Cancel", role: .cancel) {
                    // Handle the cancel action, if needed
                }
            }
        message: { detail in
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

