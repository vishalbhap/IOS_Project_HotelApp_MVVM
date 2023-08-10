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
                        }else{
                            LandmarkListView(entities: entities)
                                .navigationBarTitle("Landmarks")
                        }
                    case .loading:
                        ProgressView()
                    case .noInput:
                        Text("Enter some location")
                    default:
                        EmptyView()
                    }

                StaticLandMarkViews()
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

