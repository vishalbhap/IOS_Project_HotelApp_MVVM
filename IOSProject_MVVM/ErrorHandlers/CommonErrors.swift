//
//  CommonErrors.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 11/08/23.
//

import Foundation
import Network

enum CommonError: Error, LocalizedError{
    case invalidKey
    case requestQuotaFull
    case invalidURLRequest
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        // For developers information
        case .invalidKey:
            return "Invalid Key. API Key expired or incorrect at server end"
        case .requestQuotaFull:
            return "500 Requests crossed. Upgrade API key"
        case .invalidURLRequest:
            return "Invalid URL OR HostAPI. Check URL OR API Host Name"
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}

class NetworkManager: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "NetworkManager")
    @Published var isConnected = true

    var connectionDescription: String {
        if isConnected {
            return "Internet connection looks good"
        } else {
            return "It looks like you are not connected to Internet"
        }
    }

    var imageName: String {
        return isConnected ? "wifi" : "wifi.slash"
    }

    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}
