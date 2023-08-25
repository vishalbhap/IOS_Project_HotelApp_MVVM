//
//  CommonErrors.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 11/08/23.
//

import Foundation

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
