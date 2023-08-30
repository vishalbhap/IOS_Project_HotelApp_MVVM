//
//  LandMarkViewModel.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 08/08/23.
//

import Foundation

@MainActor
class LandMarkViewModel: ObservableObject {

    @Published var state: State = .none
    @Published var hasError: Bool = false
    @Published var textInputForLocation: String = ""
    @Published var placeName: String = ""
    private let landMarkService = LandMarkService()

    func fetchLandMarks() {
        guard !textInputForLocation.isEmpty else {
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
                    self.placeName = decodedData.term
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

    func fetchLandMarks(locationInputValue: String) {
        self.state = .loading
        self.hasError = false
        Task {
            do {
                let decodedData = try await landMarkService.fetchLandMarksData(location: locationInputValue)
                if decodedData.suggestions[0].entities.isEmpty{
                    self.state = .dataEmpty
                }else{
                    self.state = .success(data: decodedData.suggestions[0].entities)
                    self.textInputForLocation = locationInputValue
                    self.placeName = decodedData.term
                }
                textInputForLocation = ""
            } catch {
                self.state = .failed(error: error)
                self.hasError = true
            }
        }
    }



    enum State {
        case none
        case loading
        case success(data: [Entity])
        case failed(error: Error)
        case noTextInput
        case dataEmpty

        var localizedDescription: String {
            switch self {
            case .none: return "No state"
            case .loading: return "Loading"
            case .success: return "Success"
            case .failed(let error): return error.localizedDescription
            case .noTextInput: return "No input"
            case .dataEmpty: return "No Data available"
            }
        }
    }
}



