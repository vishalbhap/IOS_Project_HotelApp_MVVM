//
//  StaticLandMarkViews.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 08/08/23.
//

import SwiftUI

struct StaticLandMarkViews: View {
    @ObservedObject var landMarkViewModel: LandmarkViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                CountryProfileView(landMarkViewModel: landMarkViewModel)
                Hotel_Insights()
                HotelDiscountView(hotels: hotels)
                ReviewGridView(reviews: sampleReviews)
                HotelMessageTextView()
            }
        }
    }
}

struct StaticLandMarkViews_Previews: PreviewProvider {
    static var previews: some View {
        StaticLandMarkViews(landMarkViewModel: LandmarkViewModel())
    }
}
