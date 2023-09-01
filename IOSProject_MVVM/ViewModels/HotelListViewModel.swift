

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
                  let properties = decodedData.data?.propertySearch?.properties ?? []
                  hotels.append(contentsOf: await toHotelModels(properties: properties))
                  state = .success
              } catch {
                  handleFetchError(error)
              }
          }
      }

      private func fetchHotelData(geoId: String) async throws -> HotelListResponse {
          return try await hotelListService.fetchHotels(geoId: geoId, sortType: sortType.description, pageLimit: pageLimit, pageIndex: pageIndex)
      }

      private func handleFetchError(_ error: Error) {
          print("Error fetching hotels: \(error)")
          state = .failed(error: error)
          hasError = true
      }
    
    func toHotelModels(properties: [Properties]) async -> [CustomHotelModel] {
        var hotelModels: [CustomHotelModel] = []

        for property in properties {
            var address = "Address not available"
            let latitude = property.mapMarker.latLong.latitude
            let longitude = property.mapMarker.latLong.longitude

            address = await HotelAddressService().getAddressFromCoordinates(latitude: latitude, longitude: longitude)


            let hotelModel = CustomHotelModel(name: property.name,
                                        address: address,
                                        price: property.price?.options[0].formattedDisplayPrice ?? "Nil",
                                        strikeouprice: property.price?.options[0].strikeOut?.formatted ?? "",
                                        ratingcount: property.reviews?.total ?? 10,
                                        star: property.star ?? 3.5,
                                        destination: property.destinationInfo?.distanceFromDestination.value ?? 0,
                                        imageUrl: property.propertyImage?.image.url ?? ""
            )
            hotelModels.append(hotelModel)
        }

        return hotelModels
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





