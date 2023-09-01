//
//  ReviewByCustomer.swift
//  SwiftUI_HotelApp
//
//  Created by Yogiraj Kulkarni on 03/08/23.
//

import SwiftUI

struct ReviewByCustomer: Identifiable {

    let id = UUID()
    let customerName: String
    let reviewText: String
    let profileImageName: String
}

let sampleReviews: [ReviewByCustomer] = [
    ReviewByCustomer(customerName: "John Doe",
                     reviewText: "Great Place",
                     profileImageName: "image001"),
    ReviewByCustomer(customerName: "Kinjal Roy",
                     reviewText: "Found the best one",
                     profileImageName: "image002"),
    ReviewByCustomer(customerName: "Steve Allen",
                     reviewText: "It helped to find best",
                     profileImageName: "image003"),
    ReviewByCustomer(customerName: "Paul Albert",
                     reviewText: "I'm happy user",
                     profileImageName: "image004"),
]

struct CustomerReview: View {
    let review: ReviewByCustomer

    var body: some View {
        VStack {
            SwiftUI.Image(review.profileImageName)
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: 2))
                .padding(.bottom, 8)
            Text(review.customerName)
                .fontWeight(.semibold)
            Text(review.reviewText)
                .foregroundColor(Color.brown)
        }
    }
}

 

struct ReviewGridView: View {
    let reviews: [ReviewByCustomer]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 2), spacing: 16) {
                ForEach(reviews) { review in
                    CustomerReview(review: review)
                }
            }
            .padding(16)
        }
    }
}

struct ReviewByCustomer_Previews: PreviewProvider {
    static var previews: some View {
        ReviewGridView(reviews: sampleReviews)
    }
}
