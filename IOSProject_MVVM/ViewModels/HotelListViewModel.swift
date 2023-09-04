

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

    @Published var searchText: String = ""
    @Published var hasError: Bool = false
    @Published var state: ViewState = .none
    @Published var sortType: SortType = .RECOMMENDED
    @Published var pageLimit = 5
    @Published var pageIndex = 0
    @Published var hotels: [CustomHotelModel] = []
    
    private let hotelListService: HotelListServiceProtocol

    init(hotelListService: HotelListServiceProtocol) {
        self.hotelListService = hotelListService
    }


    var isDarkMode: Bool {
            UIScreen.main.traitCollection.userInterfaceStyle == .dark
    }
    
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

    private func fetchHotelData(geoId: String) async throws -> [CustomHotelModel] {
        return try await hotelListService.fetchHotels(geoId: geoId, sortType: sortType.description, pageLimit: pageLimit, pageIndex: pageIndex)
    }

      private func handleFetchError(_ error: Error) {
          print("Error fetching hotels: \(error)")
          state = .failed(error: error)
          hasError = true
      }
}

enum SortType: CustomStringConvertible {
    case RECOMMENDED
    case DISTANCE
    case PRICE_LOW_TO_HIGH
    case PROPERTY_CLASS

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





