//
//  HotelDiscountView.swift
//  SwiftUI_HotelApp
//
//  Created by Yogiraj Kulkarni on 02/08/23.
//

import SwiftUI

struct Hotel: Identifiable {
    let id = UUID()
    let imageName: String
}

let hotels: [Hotel] = [
    Hotel(imageName: "1"),
    Hotel(imageName: "2"),
    Hotel(imageName: "3"),
    Hotel(imageName: "4")

]
struct HotelDiscountView: View {
    var hotels: [Hotel]
    
    var body: some View {
        VStack {
            Text("OFFERS FOR YOU")
                .font(.title)
                .foregroundColor(Color.black)
               // .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem()]) {
                    ForEach(hotels) { hotel in
                        SwiftUI.Image(hotel.imageName)
                            .resizable()
                            //.scaledToFit()
                            .frame(width: 200, height: 250)
                            .cornerRadius(10)
                            .padding()
                    }
                }
            }
            Spacer()
        } 
    }
}

struct HotelDiscountView_Previews: PreviewProvider {
    static var previews: some View {
        HotelDiscountView(hotels: hotels)
    }
}
