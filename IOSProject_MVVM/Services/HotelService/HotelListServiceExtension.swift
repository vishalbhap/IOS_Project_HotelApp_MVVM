//
//  HotelListServiceExtension.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 04/09/23.
//

import Foundation


extension HotelListAPIService {

    // function for posting data to retrive list of hotels
    func postHotelRequestData(geoId: String, sortType: String, pageLimit: Int, pageIndex: Int) -> HotelRequestData {
        let hotelRequestData = HotelRequestData(
            currency: "USD",
            eapid: 1,
            locale: "en_US",
            siteId: 300000001,
            destination: Destination(regionId: geoId),
            checkInDate: DateInfo(day: 26, month: 8, year: 2023),
            checkOutDate: DateInfo(day: 30, month: 8, year: 2023),
            rooms: [Room(adults: 2, children: [Child(age: 5), Child(age: 7)])],
            resultsStartingIndex: pageIndex,
            resultsSize: pageLimit,
            sort: sortType,
            filters: Filters(price: PriceFilter(max: 150, min: 100))
        )
        return hotelRequestData
    }


    // func to convert Properties Model to CustomHotelModel
    func propertiesToHotelModelsConverter(properties: [Properties]) async -> [CustomHotelModel] {
        var hotelModels: [CustomHotelModel] = []

        for property in properties {
            var address = "Address not available"
            let latitude = property.mapMarker.latLong.latitude
            let longitude = property.mapMarker.latLong.longitude

            // calling func to get address from coordinates
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
