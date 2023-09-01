//
//  CommonServiceData.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 08/08/23.
//

import Foundation

struct APIConfig {
    static let apiKey = "dd4d13e451msh582a9a30817d001p180777jsn44020dd8023e"
    static let host = "hotels4.p.rapidapi.com"
    static let urlSession = URLSession.shared
    static let baseUrl = "https://hotels4.p.rapidapi.com/"
}


protocol DataService {

    func dataForUrl(urlRequest: URLRequest)
}

//class NetworkDataService: DataService {
//    func dataForUrl(urlRequest: URLRequest) {
//
//    }
//
//
//}
//
//
//class OfflineDataService: DataService {
//    func dataForUrl(urlRequest: URLRequest) {
//
//    }
//
//
//}
//
//
//class DataProvider {
//    var dataService: DataService
//}


//struct DataServiceConfig {
//
//
//
//}

class CommonDataService {

//    var config: DataServiceConfig

    func configureRequest(url: URL, httpMethod: String) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(APIConfig.apiKey, forHTTPHeaderField: "x-rapidapi-key")
        request.setValue(APIConfig.host, forHTTPHeaderField: "x-rapidapi-host")
        return request
    }

    func checkForCommonResponseErrors(response: HTTPURLResponse) throws {
        if response.statusCode == 403 {
            throw CommonError.invalidKey
        }
        if response.statusCode == 404 {
            throw CommonError.invalidURLRequest
        }
        if response.statusCode == 429 {
            throw CommonError.requestQuotaFull
        }
    }
    
}

enum ViewState {
    case none
    case loading
    case success
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



