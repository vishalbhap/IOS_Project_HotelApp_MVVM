

//
//  HotelListViewModel.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 16/08/23.
//

import Foundation
import CoreLocation
import MapKit
import Combine
import SwiftUI

@MainActor
class HotelListViewModel: ObservableObject {

    // Published properties that trigger UI updates when their values change.
    @Published var searchText: String = ""
    @Published var hasError: Bool = false
    @Published var state: ViewState = .none
    @Published var sortType: SortType = .RECOMMENDED
    @Published var pageLimit = 5
    @Published var pageIndex = 0
    @Published var hotels: [CustomHotelModel] = []

    // Service responsible for fetching hotel data.
    private let hotelListService: HotelListServiceProtocol

    init(hotelListService: HotelListServiceProtocol) {
        self.hotelListService = hotelListService
    }

    // Computed property to check if the app is in dark mode.
    var isDarkMode: Bool {
        UIScreen.main.traitCollection.userInterfaceStyle == .dark
    }

    // Function to fetch hotels based on a geographic ID (geoId).
    func fetchHotels(geoId: String) {
        state = .loading
        hasError = false
        Task {
            do {
                let decodedData = try await fetchHotelData(geoId: geoId)
                hotels.append(contentsOf: decodedData)
                state = .success
            } catch {
                handleFetchError(error)
            }
        }
    }

    // Function to fetch hotel data asynchronously.
    private func fetchHotelData(geoId: String) async throws -> [CustomHotelModel] {
        return try await hotelListService.fetchHotels(geoId: geoId, sortType: sortType.description, pageLimit: pageLimit, pageIndex: pageIndex)
    }

    // Function to handle fetch errors.
    private func handleFetchError(_ error: Error) {
        print("Error fetching hotels: \(error)")
        state = .failed(error: error)
        hasError = true
    }
}

// Enum representing the sorting options for hotels.
enum SortType: CustomStringConvertible {
    case RECOMMENDED
    case DISTANCE
    case PRICE_LOW_TO_HIGH
    case PROPERTY_CLASS

    // Computed property to provide a description for each sorting option.
    var description: String {
        switch self {
        case .RECOMMENDED:
            return "RECOMMENDED"
        case .DISTANCE:
            return "DISTANCE"
        case .PRICE_LOW_TO_HIGH:
            return "PRICE_LOW_TO_HIGH"
        case .PROPERTY_CLASS:
            return "PROPERTY_CLASS"
        }
    }
}






