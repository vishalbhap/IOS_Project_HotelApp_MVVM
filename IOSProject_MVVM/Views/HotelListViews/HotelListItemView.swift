//
//  HotelListItemView.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 23/08/23.
//

import Foundation
import SwiftUI

struct HotelListItemView: View {

    let index: Int
    let hotel: HotelModel

    var body: some View {
       
        if let url = URL(string: hotel.imageUrl) {
                            AsyncImageView(url: url)
                        } else {
                            Text("Invalid URL")
                        }


        VStack(alignment: .leading) {
            HStack {
                StarRatingView(rating: hotel.star) // Use the custom view here
                                   .foregroundColor(.blue)

                Text("(\(String( hotel.ratingcount)) Ratings)")
                    .font(.system(size: 14))
                Spacer()

            }
            Text(hotel.name)
                .font(Font.custom("PlayfairDisplay-Bold", size: 20))
                .fontWeight(.bold)
                .shadow(color: Color.black.opacity(0.2), radius: 3, x: 1, y: 1)
            Spacer(minLength: 1)

            Text(hotel.address)
                .font(Font.custom("Lato-Regular", size: 13))
            //                                    .fontWeight(.light)
                .opacity(0.9)
            //}
            HStack {
                SwiftUI.Image(systemName: "location.circle.fill")
                    .font(Font.custom("Lato-Regular", size: 14))
                    .foregroundColor(.blue)
                Text("\(String(format: "%.2f", hotel.destination)) Miles")
                    .font(Font.custom("Lato-Regular", size: 15))
                    .fontWeight(.light)

                VStack {
                    Text(hotel.strikeouprice)
                        .font(Font.custom("Pacifico-Regular", size: 15))
                        .strikethrough()
                        .foregroundColor(.red)

                    Text(hotel.price)
                        .font(Font.custom("PlayfairDisplay-Bold", size: 20))
                        .fontWeight(.bold)

                }
                .frame(maxWidth: .infinity, alignment: .trailing)

            }
        }
    }
}



struct StarRatingView: View {
    let rating: Double

    var body: some View {
        HStack(spacing: 2) {
            ForEach(1...5, id: \.self) { index in
                let starState: StarState = starState(for: index)

                SwiftUI.Image(systemName: starState.imageName)
                    .font(.system(size: 16))
                    .foregroundColor(starState.color)
            }
        }
    }

    private func starState(for index: Int) -> StarState {
        let fullStars = Int(rating)
        let remainder = rating - Double(fullStars)

        if index <= fullStars {
            return StarState(imageName: "star.fill", color: .blue)
        } else if index == fullStars + 1 && remainder >= 0.25 && remainder < 0.75 {
            return StarState(imageName: "star.leadinghalf.fill", color: .blue)
        } else if index == fullStars + 1 && remainder >= 0.75 {
            return StarState(imageName: "star.fill", color: .blue)
        } else {
            return StarState(imageName: "star", color: .blue)
        }
    }
}

struct StarState {
    let imageName: String
    let color: Color
}

