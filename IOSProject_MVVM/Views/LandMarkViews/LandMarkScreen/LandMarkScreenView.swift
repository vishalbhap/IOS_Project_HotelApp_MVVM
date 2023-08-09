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
    @State private var textInputForLocation: String = ""
    @State private var showLandmarkList: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(textInput: $textInputForLocation, searchAction: {
                                    landMarkViewModel.fetchLandMarks(country: textInputForLocation)
                                    textInputForLocation = ""
                                    showLandmarkList = true
                                })

                if landMarkViewModel.isSearching {
                    ProgressView()
                }

                Text(landMarkViewModel.landMarkResponseMessage)

                if showLandmarkList {
                    LandmarkListView(entities: landMarkViewModel.entities)
                } else {
                    StaticLandMarkViews()
                }
            }
            .navigationBarTitle("Landmarks")
        }
    }
}


struct LandMarkScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LandMarkScreenView()
    }
}

