//
//  HotelAddressService.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 23/08/23.
//

import Foundation
import CoreLocation
import MapKit
import Combine
import SwiftUI

struct HotelAddressService{
    func getAddressFromCoordinates(latitude: Double, longitude: Double) async -> String {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()

        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(location)

            if let placemark = placemarks.first {
                let address = stringFromPlacemark(placemark)
                return address
            } else {
                return "Address not available"
            }
        } catch {
            print("Geocoding Error: \(error.localizedDescription)")
            return "Address not found"
        }
    }

    func stringFromPlacemark(_ placemark: CLPlacemark) -> String {
        var address = ""
        if let name = placemark.name {
            address += name + ", "
        }
        if let street = placemark.thoroughfare {
            address += street + ", "
        }
        if let city = placemark.locality {
            address += city + ", "
        }
        if let state = placemark.administrativeArea {
            address += state + " "
        }
        if let postalCode = placemark.postalCode {
            address += postalCode + ", "
        }
        if let country = placemark.country {
            address += country
        }

        return address.isEmpty ? "Address not found" : address
    }
}


