//
//  HotelAddressService.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 23/08/23.
//

import CoreLocation

struct HotelAddressService {

    // Function to get an address from coordinates
    func getAddressFromCoordinates(latitude: Double, longitude: Double) async -> String {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()

        do {
            // Perform reverse geocoding to get placemarks from coordinates
            let placemarks = try await geocoder.reverseGeocodeLocation(location)

            if let placemark = placemarks.first {
                // Convert the placemark into a formatted address string
                let address = stringFromPlacemark(placemark)
                return address
            } else {
                // No placemarks found, return a message indicating address not available
                return "Address not available"
            }
        } catch {
            // Handle geocoding errors and return an error message
            print("Geocoding Error: \(error.localizedDescription)")
            return "Address not found"
        }
    }

    // Function to convert a CLPlacemark into a formatted address string
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

        // If no address components were found, return a message indicating address not found
        return address.isEmpty ? "Address not found" : address
    }
}



