//
//  HotelListScreenView.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 16/08/23.
//
import SwiftUI

struct HotelListScreenView: View {
    var geoId: String?
    @ObservedObject var hotelListViewModel = HotelListViewModel()
    @State private var selectedSortType: SortType = .RECOMMENDED
    @State var searchText: String = ""


    var body: some View {
        VStack {
            HotelSearchBar(searchText: $searchText)
            
            SortingButtonView(hotelListViewModel: hotelListViewModel, selectedSortType: $selectedSortType)

            List(Array(filteredHotels.enumerated()), id: \.element.id) { index, hotel in
                HotelListItemView(index: index, hotel: hotel)
                    .onAppear {
                        if hotel.id == hotelListViewModel.hotels.last?.id {
                            paginateHotels()
                        }
                    }
            }
            if case .loading = hotelListViewModel.state {
                ProgressView()
            }
        }
        .onAppear {
            fetchHotels()
        }
        .alert(isPresented: $hotelListViewModel.hasError) {
            errorAlert
        }
    }
}

struct HotelListScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HotelListScreenView(geoId: "1598")
    }
}
