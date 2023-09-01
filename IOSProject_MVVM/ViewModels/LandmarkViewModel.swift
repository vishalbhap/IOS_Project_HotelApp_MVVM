//
//  LandMarkViewModel.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 08/08/23.
//

import Foundation

protocol LandmarkViewModelProtocol: ObservableObject {
    func fetchLandMarks() async
}

@MainActor
class LandmarkViewModel: LandmarkViewModelProtocol {

    @Published var hasError: Bool = false
    @Published var textInputForLocation: String = ""
    @Published var placeName: String = ""
    @Published var state: ViewState = .none

    @Published var entities: [Entity] = []
    private let landMarkService: LandmarkServiceProtocol


    init(landMarkService: LandmarkServiceProtocol) {
        self.landMarkService = landMarkService
    }

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
                    self.state = .success
                    self.entities = decodedData.suggestions[0].entities
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

}







