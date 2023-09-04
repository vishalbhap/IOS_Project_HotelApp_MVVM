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

    // View for the hotel search bar
    var HotelSearchBarView: some View {
        HotelSearchBar(hotelListViewModel: hotelListViewModel, searchText: $hotelListViewModel.searchText)
    }

    // View for sorting buttons
    var SortedButtonsView: some View {
        SortingButtonView(hotelListViewModel: hotelListViewModel, selectedSortType: $hotelListViewModel.sortType, geoId: geoId!)
    }

    // View for displaying the list of hotels
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

    // View for displaying a loading indicator when fetching hotels
    var HotelProgessView: some View {
        VStack {
            if case .loading = hotelListViewModel.state {
                ProgressView()
                Text("Fetching Hotels")
            }
        }
    }

    // Alert for displaying errors
    var errorAlert: Alert {
        Alert(
            title: Text("Error"),
            message: Text(hotelListViewModel.state.localizedDescription),
            primaryButton: .default(Text("Retry"), action: retryFetchingHotels),
            secondaryButton: .cancel(Text("Cancel"))
        )
    }

    // Back button to go back to the previous page
    var BackButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss() // Go back to the previous page
        }) {
            SwiftUI.Image(systemName: "chevron.left") // Use your back arrow icon here
                .foregroundColor(.blue) // Adjust color as needed
                .imageScale(.large)
        }
    }

    // Logout button to log out the user
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

// Functions for HotelListScreenView
extension HotelListScreenView {

    // Function to fetch hotels
    func fetchHotels() {
        hotelListViewModel.fetchHotels(geoId: geoId ?? "1598")
    }

    // Function to paginate hotels
    func paginateHotels() {
        print("DEBUG: Paginate here")
        hotelListViewModel.pageIndex += hotelListViewModel.pageLimit
        fetchHotels()
    }

    // Function to retry fetching hotels
    func retryFetchingHotels() {
        fetchHotels()
    }

    // Filtered list of hotels based on search text
    var filteredHotels: [CustomHotelModel] {
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
