//
//  HotelListSubViews.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 30/08/23.
//

import Foundation
import SwiftUI

// Hotel SearchBar View
struct HotelSearchBar : View {

    @ObservedObject var hotelListViewModel:HotelListViewModel
    @Binding var searchText: String
    @State var isSearching = false

    var body : some View {
        VStack{
            TextField("Search hotels here", text: $searchText)
                .padding(.leading, 30)
                .frame(width: 327,height: 1)
                .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                .shadow(color: Color.black.opacity(0.06), radius: 5, x: -5, y: -5)
                .padding()
                .background(Color.white)
                .cornerRadius(5)
                .padding(.horizontal)
                .onTapGesture(perform: {
                    isSearching = true
                })
                .environment(\.colorScheme, hotelListViewModel.isDarkMode ? .dark : .light)
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
    }
}

// Hotel SortingButtonView
struct SortingButtonView: View {
    @ObservedObject var hotelListViewModel:HotelListViewModel
    @Binding var selectedSortType: SortType
    var geoId: String

    @MainActor func applySorting(_ sortType: SortType) {
            hotelListViewModel.hotels = []
            hotelListViewModel.pageIndex = 0
            hotelListViewModel.sortType = sortType
            hotelListViewModel.fetchHotels(geoId: geoId)
    }

    var body: some View {
        HStack{
            Button("Recommended") {
                applySorting(.RECOMMENDED)
                selectedSortType = .RECOMMENDED
            }
            .modifier(ButtonHighlightModifier(selectedSortType: selectedSortType, sortType: .RECOMMENDED))

            Button("Low to High") {
                applySorting(.PRICE_LOW_TO_HIGH)
                selectedSortType = .PRICE_LOW_TO_HIGH
            }
            .modifier(ButtonHighlightModifier(selectedSortType: selectedSortType, sortType: .PRICE_LOW_TO_HIGH))

            Button("Distance") {
                applySorting(.DISTANCE)
                selectedSortType = .DISTANCE
            }
            .modifier(ButtonHighlightModifier(selectedSortType: selectedSortType, sortType: .DISTANCE))

            Button("Star Rating") {
                applySorting(.PROPERTY_CLASS)
                selectedSortType = .PROPERTY_CLASS
            }
            .modifier(ButtonHighlightModifier(selectedSortType: selectedSortType, sortType: .PROPERTY_CLASS))
        }
    }
}

// View Modifier for Button Highlight
struct ButtonHighlightModifier: ViewModifier {
    var selectedSortType: SortType
    var sortType: SortType

    func body(content: Content) -> some View {
        content
            .padding(10)
            .background(selectedSortType == sortType ? Color.blue.opacity(0.5) : Color.clear)
            .cornerRadius(8)
            .foregroundColor(selectedSortType == sortType ? Color.white : Color.primary)
    }
}

// Hotel List Item View
struct HotelListItemView: View {

    let index: Int
    let hotel: CustomHotelModel

    var body: some View {
        VStack(alignment: .leading) {
            if let url = URL(string: hotel.imageUrl) {
                AsyncImageView(url: url)
            } else {
                Text("Invalid URL")
            }

            HStack {
                StarRatingView(rating: hotel.star)
                                   .foregroundColor(.blue)

                Text("(\(String( hotel.ratingcount)) Ratings)")
                    .font(.system(size: 14))
                Spacer()
            }

            Text(hotel.name)
                .font(Font.custom("PlayfairDisplay-Bold", size: 20))
                .fontWeight(.bold)
                .shadow(color: Color.black.opacity(0.2), radius: 3, x: 1, y: 1)

            Spacer(minLength: 1)

            Text(hotel.address)
                .font(Font.custom("Lato-Regular", size: 13))
                .opacity(0.9)

            HStack {
                SwiftUI.Image(systemName: "location.circle.fill")
                    .font(Font.custom("Lato-Regular", size: 14))
                    .foregroundColor(.blue)

                Text("\(String(format: "%.2f", hotel.destination)) Miles")
                    .font(Font.custom("Lato-Regular", size: 15))
                    .fontWeight(.light)

                VStack {
                    Text(hotel.strikeouprice)
                        .font(Font.custom("Pacifico-Regular", size: 15))
                        .strikethrough()
                        .foregroundColor(.red)

                    Text(hotel.price)
                        .font(Font.custom("PlayfairDisplay-Bold", size: 20))
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
}

// View for displaying star rating
struct StarRatingView: View {
    let rating: Double

    var body: some View {
        HStack(spacing: 2) {
            ForEach(1...5, id: \.self) { index in
                let starState: StarState = starState(for: index)

                SwiftUI.Image(systemName: starState.imageName)
                    .font(.system(size: 16))
                    .foregroundColor(starState.color)
            }
        }
    }

    private func starState(for index: Int) -> StarState {
        let fullStars = Int(rating)
        let remainder = rating - Double(fullStars)

        if index <= fullStars {
            return StarState(imageName: "star.fill", color: .blue)
        } else if index == fullStars + 1 && remainder >= 0.25 && remainder < 0.75 {
            return StarState(imageName: "star.leadinghalf.fill", color: .blue)
        } else if index == fullStars + 1 && remainder >= 0.75 {
            return StarState(imageName: "star.fill", color: .blue)
        } else {
            return StarState(imageName: "star", color: .blue)
        }
    }
}

// Model for Star Rating
struct StarState {
    let imageName: String
    let color: Color
}
