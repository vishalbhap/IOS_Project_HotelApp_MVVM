//
//  HotelListService.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 16/08/23.
//

import Foundation

// Protocol defining the interface for a HotelListService.
protocol HotelListServiceProtocol {
    func fetchHotels(geoId: String, sortType: String, pageLimit: Int, pageIndex: Int) async throws -> [CustomHotelModel]
}

// Implementation of HotelListService using a real API.
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

        // creating request onject with common headers
        var request = CommonDataService().configureRequest(url: url, httpMethod: "POST")
        request.httpBody = jsonData

        let (data, response) = try await APIConfig.urlSession.data(for: request)

        // checking for common errors
        try CommonDataService().checkForCommonResponseErrors(response: response as! HTTPURLResponse)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            throw LandmarkServiceError.serverError
        }

        do {
            let decodedData = try JSONDecoder().decode(HotelListResponse.self, from: data)
            return await propertiesToHotelModelsConverter(properties: decodedData.data?.propertySearch?.properties ?? [])
        } catch {
            throw HotelListServiceError.invalidData
        }
    }
}



// Mock implementation of HotelListService for testing purposes.
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
