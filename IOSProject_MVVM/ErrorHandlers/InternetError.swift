//
//  NetworkError.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 11/08/23.
//

import Foundation
import Network

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

