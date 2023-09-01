//
//  Hotel_Insights.swift
//  SwiftUI_HotelApp
//
//  Created by Yogiraj Kulkarni on 02/08/23.
//

import SwiftUI


struct Hotel_Insights: View {
    @State private var currentIndex = 0
    let images: [String] = ["one", "two", "three", "four", "five", "six", "seven"]
    var body: some View {
        VStack {
            Text("Insights And Views")
                .font(.title)
                .foregroundColor(Color.black)
            // Use transition to animate image changes
            SwiftUI.Image(images[currentIndex])
                .resizable()
                .scaledToFit()
                .transition(.opacity) // Apply fade-in and fade-out
            Spacer()
        }
        .onAppear {
            animateImages()
        }
    }
    func animateImages() {
        withAnimation(.easeInOut(duration: 1.0)) {
            if currentIndex + 1 == images.count {
                currentIndex = 0
            } else {
                currentIndex += 1
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            animateImages()
        }
    }
}
struct Hotel_Insights_Previews: PreviewProvider {
    static var previews: some View {
        Hotel_Insights()
    }
}

