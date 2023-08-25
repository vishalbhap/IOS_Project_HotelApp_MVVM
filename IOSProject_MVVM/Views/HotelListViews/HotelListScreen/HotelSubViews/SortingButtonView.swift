//
//  SortingButtonView.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 23/08/23.
//

import Foundation
import SwiftUI

struct SortingButtonView: View {

    @ObservedObject var hotelListViewModel:HotelListViewModel
    @Binding var selectedSortType: SortType

    @MainActor func applySorting(_ sortType: SortType) {
            hotelListViewModel.hotels = []
            hotelListViewModel.pageIndex = 0
            hotelListViewModel.sortType = sortType
            hotelListViewModel.fetchHotels(geoId: "1598")
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
