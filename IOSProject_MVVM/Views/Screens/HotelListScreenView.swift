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
    @ObservedObject var landMarkViewModel: LandMarkViewModel = LandMarkViewModel()
    @EnvironmentObject var loginViewModel: LoginViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            HotelSearchBar(searchText: $searchText)
            
            SortingButtonView(hotelListViewModel: hotelListViewModel, selectedSortType: $selectedSortType, geoId: geoId!)

            HotelListView
            
            if case .loading = hotelListViewModel.state {
                ProgressView()
                Text("Fetching Hotels")
            }
        }
        .onAppear {
            fetchHotels()
        }
        .alert(isPresented: $hotelListViewModel.hasError) {
            errorAlert
        }
        .navigationTitle("Explore your hotel")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing:LogoutButton )
        .navigationBarItems(leading: BackButton )
    }
}

struct HotelListScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HotelListScreenView(geoId: "1598")
    }
}
