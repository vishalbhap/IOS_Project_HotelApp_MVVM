//
//  StaticLandMarkViews.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 08/08/23.
//

import SwiftUI

struct StaticLandMarkViews: View {
    var body: some View {
        ScrollView {
            VStack {
                CountryProfileView()
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
        StaticLandMarkViews()
    }
}
