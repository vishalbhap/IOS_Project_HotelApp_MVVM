//
//  HotelListService.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 16/08/23.
//

import Foundation

protocol HotelListServiceProtocol {
    func fetchHotels(geoId: String, sortType: String, pageLimit: Int, pageIndex: Int) async throws -> [CustomHotelModel]
}

class HotelListAPIService: HotelListServiceProtocol {

    func fetchHotels(geoId: String, sortType: String, pageLimit: Int, pageIndex: Int) async throws -> [CustomHotelModel] {
        guard let url = URL(string: "https://hotels4.p.rapidapi.com/properties/v2/list") else {
            throw HotelListServiceError.invalidURL
        }

        let hotelRequestData = postHotelRequestData(geoId: geoId, sortType: sortType, pageLimit: pageLimit, pageIndex: pageIndex)
        guard let jsonData = try? JSONEncoder().encode(hotelRequestData) else {
            print("Error encoding data.")
            throw HotelListServiceError.encodingFailed
        }

        var request = CommonDataService().configureRequest(url: url, httpMethod: "POST")
        request.httpBody = jsonData
        let (data, response) = try await URLSession.shared.data(for: request)

        try CommonDataService().checkForCommonResponseErrors(response: response as! HTTPURLResponse)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            throw LandmarkServiceError.serverError
        }

        do {
            let decodedData = try JSONDecoder().decode(HotelListResponse.self, from: data)
            return await toHotelModels(properties: decodedData.data?.propertySearch?.properties ?? [])
        } catch {
            throw HotelListServiceError.invalidData
        }
    }


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



class HotelListMockService: HotelListServiceProtocol {

    func fetchHotels(geoId: String, sortType: String, pageLimit: Int, pageIndex: Int) async throws -> [CustomHotelModel] {

        let hotels: [CustomHotelModel] = [
            CustomHotelModel(name: "Marriot", address: "SB Road, Pune Maharashtra", price: "123$", strikeouprice: "150$", ratingcount: 151, star: 4.5, destination: 20.5, imageUrl: "https://images.trvl-media.com/lodging/93000000/92550000/92549400/92549336/fa48168d.jpg?impolicy=resizecrop&rw=455&ra=fit"),
            CustomHotelModel(name: "Lemeredian", address: "SB Road, Pune Maharashtra", price: "123$", strikeouprice: "150$", ratingcount: 151, star: 4.5, destination: 20.5, imageUrl: "https://images.trvl-media.com/lodging/1000000/20000/17700/17640/a250b542.jpg?impolicy=resizecrop&rw=455&ra=fit"),
            CustomHotelModel(name: "Hyat", address: "SB Road, Pune Maharashtra", price: "123$", strikeouprice: "150$", ratingcount: 151, star: 4.5, destination: 20.5, imageUrl: "https://images.trvl-media.com/lodging/96000000/95240000/95233900/95233817/0391f9c1.jpg?impolicy=resizecrop&rw=455&ra=fit"),
            CustomHotelModel(name: "Taj", address: "SB Road, Pune Maharashtra", price: "123$", strikeouprice: "150$", ratingcount: 151, star: 4.5, destination: 20.5, imageUrl: "https://images.trvl-media.com/lodging/96000000/95240000/95233900/95233817/0391f9c1.jpg?impolicy=resizecrop&rw=455&ra=fit"),
            CustomHotelModel(name: "Shiv Sagar", address: "SB Road, Pune Maharashtra", price: "123$", strikeouprice: "150$", ratingcount: 151, star: 4.5, destination: 20.5, imageUrl: "https://images.trvl-media.com/lodging/96000000/95240000/95233900/95233817/0391f9c1.jpg?impolicy=resizecrop&rw=455&ra=fit"),
            CustomHotelModel(name: "Gandharv", address: "SB Road, Pune Maharashtra", price: "123$", strikeouprice: "150$", ratingcount: 151, star: 4.5, destination: 20.5, imageUrl: "https://images.trvl-media.com/lodging/96000000/95240000/95233900/95233817/0391f9c1.jpg?impolicy=resizecrop&rw=455&ra=fit"),
            CustomHotelModel(name: "Gavran Tadka", address: "SB Road, Pune Maharashtra", price: "123$", strikeouprice: "150$", ratingcount: 151, star: 4.5, destination: 20.5, imageUrl: "https://images.trvl-media.com/lodging/96000000/95240000/95233900/95233817/0391f9c1.jpg?impolicy=resizecrop&rw=455&ra=fit")

        ]

        return hotels

    }


}
