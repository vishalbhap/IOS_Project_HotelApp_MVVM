

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

    @Published var sortType: SortType = .RECOMMENDED

    @Published var state: State = .none
    @Published var hasError: Bool = false
    
    @Published var hotelListResponse: HotelListResponse?
    @Published var properties: [Properties] = []
    @Published var hotels: [HotelModel] = []
    
    private let hotelListService = HotelListService()

    @Published var pageLimit = 5
    @Published var pageIndex = 0
    
    func fetchHotels(geoId: String) {
        self.state = .loading
        self.hasError = false
        Task {
            do {
                let decodedData = try await hotelListService.fetchHotels(geoId: geoId, sortType: sortType.description, pageLimit: self.pageLimit, pageIndex: self.pageIndex)
                self.properties = (decodedData.data?.propertySearch?.properties) ?? []
                let hotelList = await toHotelModels(properties: self.properties)
                self.hotels.append(contentsOf: hotelList)
                self.state = .success(data: self.hotels)
            } catch {
                print("Error fetching citiess: \(error)")
                self.state = .failed(error: error)
                self.hasError = true
            }
        }
    }
    
    func toHotelModels(properties: [Properties]) async -> [HotelModel] {
        var hotelModels: [HotelModel] = []

        for property in properties {
            var address = "Address not available"
            let latitude = property.mapMarker.latLong.latitude
            let longitude = property.mapMarker.latLong.longitude

            address = await HotelAddressService().getAddressFromCoordinates(latitude: latitude, longitude: longitude)


            let hotelModel = HotelModel(name: property.name,
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

    enum State {
        case none
        case loading
        case success(data: [HotelModel])
        case failed(error: Error)

        var localizedDescription: String {
            switch self {
            case .none:
                return "No state"
            case .loading:
                return "Loading"
            case .success:
                return "Success"
            case .failed(let error):
                return error.localizedDescription
            }
        }
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





