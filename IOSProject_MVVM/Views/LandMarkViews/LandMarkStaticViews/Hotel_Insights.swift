//
//  Hotel_Insights.swift
//  SwiftUI_HotelApp
//
//  Created by Yogiraj Kulkarni on 02/08/23.
//

import SwiftUI


struct Hotel_Insights: View {    
    
    // Images index
    @State private var currentIndex = 0
    let images : [String] = ["one","two","three","four","five","six","seven"]
        
    var body: some View {
        VStack{
            Text("Insights And Views")
                .font(.title)
                .foregroundColor(Color.black)
            SwiftUI.Image(images[currentIndex])
                .resizable()
               .scaledToFit()
            HStack{
                ForEach(0..<images.count, id: \.self){
                    index in Circle()
                        .fill(self.currentIndex == index ? Color.red: Color.brown)
                        .frame(width: 10, height: 10)
                }
            }
           Spacer()
        }
       //.padding()
        .onAppear{
            Timer.scheduledTimer(withTimeInterval: 2, repeats: true){
                timer in
                if self.currentIndex + 1 == self.images.count{
                    self.currentIndex = 0
                }else{
                    self.currentIndex +=  1
                }
            }
        }
    }
}

struct Hotel_Insights_Previews: PreviewProvider {
    static var previews: some View {
        Hotel_Insights()
    }
}
