//
//  HotelListService.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 16/08/23.
//

import Foundation

//protocol HotelListServiceProtocol {
//    func fetchLandMarksData(location: String) async throws -> LandmarkModelResponse
//}

class HotelListService{

    func fetchHotels(geoId: String, sortType: String, pageLimit: Int, pageIndex: Int) async throws -> HotelListResponse {
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
            return decodedData
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
}
