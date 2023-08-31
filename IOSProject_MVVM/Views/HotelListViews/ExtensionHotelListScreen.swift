//
//  ExtensionHotelListScreen.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 30/08/23.
//

import Foundation
import SwiftUI

// HotelList Sub Views
extension HotelListScreenView {

    var HotelSearchBarView: some View {
        HotelSearchBar(hotelListViewModel: hotelListViewModel, searchText: $hotelListViewModel.searchText)
    }

    var SortedButtonsView: some View {
        SortingButtonView(hotelListViewModel: hotelListViewModel, selectedSortType: $hotelListViewModel.sortType, geoId: geoId!)
    }

    var HotelListView: some View {
        List(Array(filteredHotels.enumerated()), id: \.element.id) { index, hotel in
            HotelListItemView(index: index, hotel: hotel)
                .onAppear {
                    if hotel.id == hotelListViewModel.hotels.last?.id {
                        paginateHotels()
                    }
                }
        }
    }

    var HotelProgessView: some View {
        VStack{
            if case .loading = hotelListViewModel.state {
                ProgressView()
                Text("Fetching Hotels")
            }
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

    var BackButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss() // Go back to previous page
        }) {
            SwiftUI.Image(systemName: "chevron.left") // Use your back arrow icon here
                .foregroundColor(.blue) // Adjust color as needed
                .imageScale(.large)
        }
    }

    var LogoutButton: some View {
        Button(action: {
            landMarkViewModel.logout()
            loginViewModel.isLoggedIn = false
        }) {
            Text("Logout")
                .foregroundColor(.red)
        }
    }
}


// Functions HotelList
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
        if hotelListViewModel.searchText.count >= 3 {
            return hotelListViewModel.hotels.filter { hotel in
                let searchTextLowercased = hotelListViewModel.searchText.lowercased()
                let nameContainsSearchText = hotel.name.lowercased().contains(searchTextLowercased)
                let addressContainsSearchText = hotel.address.lowercased().contains(searchTextLowercased)
                return nameContainsSearchText || addressContainsSearchText
            }
        } else {
            return hotelListViewModel.hotels
        }
    }

}

