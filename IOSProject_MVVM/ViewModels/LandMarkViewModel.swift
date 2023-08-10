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
        case na
        case loading
        case success(data: [Entity])
        case failed(error: Error)
        case noInput
    }

    @Published var state: State = .na
    @Published var hasError: Bool = false
    @Published var textInputForLocation: String = ""
    private let landMarkService = LandMarkService()

    func fetchLandMarks() {
        if textInputForLocation.isEmpty {
                    self.state = .noInput
                    return
                }
        self.state = .loading
        self.hasError = false
        Task {
            do {
                let decodedData = try await landMarkService.fetchLandMarksData(location: textInputForLocation)
                self.state = .success(data: decodedData.suggestions[0].entities)
                textInputForLocation = ""
            } catch {
                self.state = .failed(error: error)
                self.hasError = true
            }
        }
    }
}



