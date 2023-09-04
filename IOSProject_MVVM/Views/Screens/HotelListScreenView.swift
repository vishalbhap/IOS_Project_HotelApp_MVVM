//
//  HotelListScreenView.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 16/08/23.
//
import SwiftUI

import SwiftUI

// A view for the hotel list screen.
struct HotelListScreenView: View {
    var geoId: String?
    @ObservedObject var hotelListViewModel = HotelListViewModel(hotelListService: HotelListAPIService())
    @ObservedObject var landMarkViewModel: LandmarkViewModel = LandmarkViewModel(landMarkService: LandmarkAPIService())
    @EnvironmentObject var loginViewModel: LoginViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            // Search bar for hotels (You can replace HotelSearchBarView with your own)
            HotelSearchBarView

            // Buttons for sorting hotels (You can replace SortedButtonsView with your own)
            SortedButtonsView

            // Display the hotel list (You can replace HotelListView with your own)
            HotelListView

            // Progress view for loading hotels (You can replace HotelProgessView with your own)
            HotelProgessView
        }
        .onAppear {
            fetchHotels() // Fetch hotels when the view appears
        }
        .alert(isPresented: $hotelListViewModel.hasError) {
            errorAlert // Show an error alert if there's an error
        }
        .navigationTitle("Explore your hotel")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing: LogoutButton) // Add a logout button to the navigation bar
        .navigationBarItems(leading: BackButton) // Add a back button to the navigation bar
    }
}

// Preview for the HotelListScreenView.
struct HotelListScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HotelListScreenView(geoId: "1598")
    }
}

