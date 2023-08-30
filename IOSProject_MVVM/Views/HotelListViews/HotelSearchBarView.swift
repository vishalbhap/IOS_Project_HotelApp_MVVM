//
//  HotelSearchBarView.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 23/08/23.
//

import Foundation
import SwiftUI

struct HotelSearchBar : View {

    @Binding var searchText: String
    @State var isSearching = false

    var body : some View {
        VStack{
//            Text("Explore Your Hotel..!")
//                .foregroundColor(Color.white)
//                .font(Font.custom("PlayfairDisplay-Bold", size: 22))
//                .fontWeight(.bold)
            TextField("Search hotels here", text: $searchText)
                .padding(.leading, 30)
                .foregroundColor(Color.black)
                .frame(width: 327,height: 1)
                .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                .shadow(color: Color.black.opacity(0.06), radius: 5, x: -5, y: -5)

                .padding()
            //  .background(Color(.systemGray5))
                .background(Color.white)
                .cornerRadius(5)
                .padding(.horizontal)
                .onTapGesture(perform: {
                    isSearching = true
                })
                .overlay(
                    HStack {
                        SwiftUI.Image(systemName: "magnifyingglass")
                        Spacer()
                        if isSearching {
                            Button {
                                searchText = ""
                            } label: {
                                SwiftUI.Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(Color.black)
                            }
                        }
                    }
                        .padding(.horizontal, 32)
                )
        }
        .padding(.bottom, 20)
        .background(Color.white)
    }
    
}
