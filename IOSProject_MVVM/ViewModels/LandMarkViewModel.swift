//
//  LandMarkViewModel.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 08/08/23.
//

import Foundation

class LandMarkViewModel: ObservableObject {
    @Published var landMarkResponse: LandMarkModelResponse?
    @Published var entities: [Entity] = []
    @Published var isSearching: Bool = false
    @Published var landMarkResponseMessage:String = ""

    private let landMarkService = LandMarkService()


    func fetchLandMarks(location: String) {
        if location == "" {
            landMarkResponseMessage = "Please enter some location"
            return
        }
        self.landMarkResponseMessage = ""
        self.isSearching = true
        Task {
            do {
                let decodedData = try await landMarkService.fetchLandMarksData(location: location)

                DispatchQueue.main.async {
                    self.landMarkResponse = decodedData
                    self.entities = decodedData.suggestions[0].entities
                    self.isSearching = false
                    if self.entities.isEmpty {
                        self.landMarkResponseMessage = "No landmarks found for this location"
                    }
                }
            } catch {
                print("Error fetching cities: \(error)")
                self.isSearching = false
                self.landMarkResponseMessage = "Error fetching landmarks"
            }
        }
    }    
}




































//class LandMarkViewModel : ObservableObject {
//    @Published var landMarkResponse:LandMarkModelResponse?
//    @Published var entities:[Entity] = []
//
//    func fetchCities(country:String) {
//        guard let url = URL(string: "https://hotels4.p.rapidapi.com/locations/v2/search?query=\(country)") else {
//            return
//        }
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("a5dc511090mshe2f6e52f07d26aep1f378fjsncf83e7ea63c9", forHTTPHeaderField: "x-rapidapi-key")
//        request.setValue("hotels4.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                return
//            }
//
//            do {
//                let decodedData = try JSONDecoder().decode(LandMarkModelResponse.self, from: data)
//                    DispatchQueue.main.async {
//                        self.landMarkResponse = decodedData
//                        print(self.landMarkResponse?.suggestions[0].entities)
//                        self.entities = (self.landMarkResponse?.suggestions[0].entities)!
//
//                    }
//            } catch {
//                print("Error decoding JSON: \(error)")
//            }
//        }.resume()
//    }
//}
