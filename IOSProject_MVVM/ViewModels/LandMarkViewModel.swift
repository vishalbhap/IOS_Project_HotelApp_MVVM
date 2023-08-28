//
//  LandMarkViewModel.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 08/08/23.
//

import Foundation

@MainActor
class LandMarkViewModel: ObservableObject {

    enum State {
        case none
        case loading
        case success(data: [Entity])
        case failed(error: Error)
        case noTextInput
        case dataEmpty
    }

    @Published var state: State = .none
    @Published var hasError: Bool = false
    @Published var textInputForLocation: String = ""
    private let landMarkService = LandMarkService()

    func fetchLandMarks() {
        if textInputForLocation.isEmpty {
                    self.state = .noTextInput
                    return
                }
        self.state = .loading
        self.hasError = false
        Task {
            do {
                let decodedData = try await landMarkService.fetchLandMarksData(location: textInputForLocation)
                if decodedData.suggestions[0].entities.isEmpty{
                    self.state = .dataEmpty
                }else{
                    self.state = .success(data: decodedData.suggestions[0].entities)
                }
                textInputForLocation = ""
            } catch {
                self.state = .failed(error: error)
                self.hasError = true
            }
        }
    }



    func logout() {
            // Implement logout actions here
            // This might include clearing user data, resetting the login state, etc.
        }

    func fetchLandMarks(countryName: String) {
        self.state = .loading
        self.hasError = false
        Task {
            do {
                let decodedData = try await landMarkService.fetchLandMarksData(location: countryName)
                if decodedData.suggestions[0].entities.isEmpty{
                    self.state = .dataEmpty
                }else{
                    self.state = .success(data: decodedData.suggestions[0].entities)
                    self.textInputForLocation = countryName
                }
                textInputForLocation = ""
            } catch {
                self.state = .failed(error: error)
                self.hasError = true
            }
        }
    }
}



