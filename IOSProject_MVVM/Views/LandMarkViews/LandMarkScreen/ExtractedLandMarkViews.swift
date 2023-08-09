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

    var body: some View {
        List(entities) { entity in
            Text(entity.name)
                .foregroundColor(.blue)
                .padding()
                
        }
    }
}

