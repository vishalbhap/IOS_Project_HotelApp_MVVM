//
//  HotelListViewFunctionalities.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 23/08/23.
//

import Foundation
import SwiftUI

extension HotelListScreenView {

    func fetchHotels() {
        hotelListViewModel.fetchHotels(geoId: geoId ?? "1598")
    }

    func paginateHotels() {
        print("DEBUG: Paginate here")
        hotelListViewModel.pageIndex += hotelListViewModel.pageLimit
        fetchHotels()
    }

    func retryFetchingHotels() {
        fetchHotels()
    }

    var filteredHotels: [HotelModel] {
        if searchText.count >= 3 {
            return hotelListViewModel.hotels.filter { hotel in
                let searchTextLowercased = searchText.lowercased()
                let nameContainsSearchText = hotel.name.lowercased().contains(searchTextLowercased)
                let addressContainsSearchText = hotel.address.lowercased().contains(searchTextLowercased)
                return nameContainsSearchText || addressContainsSearchText
            }
        } else {
            return hotelListViewModel.hotels
        }
    }

    var errorAlert: Alert {
        Alert(
            title: Text("Error"),
            message: Text(hotelListViewModel.state.localizedDescription),
            primaryButton: .default(Text("Retry"), action: retryFetchingHotels),
            secondaryButton: .cancel(Text("Cancel"))
        )
    }

    
}
