//
//  TextView.swift
//  SwiftUI_HotelApp
//
//  Created by Yogiraj Kulkarni on 02/08/23.
//

import SwiftUI

struct HotelMessageTextView: View {
    var body: some View {
        VStack{
            Text("START SEARCHING YOUR HOTEL HERE WITH SOME AMAZING DISCOUNTS")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding()
        }  
    }
}

struct HotelMessageTextView_Previews: PreviewProvider {
    static var previews: some View {
        HotelMessageTextView()
    }
}
