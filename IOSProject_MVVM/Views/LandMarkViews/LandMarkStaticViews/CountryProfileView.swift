//
//  CountryProfileView.swift
//  SwiftUI_HotelApp
//
//  Created by Yogiraj Kulkarni on 02/08/23.
//

import SwiftUI
struct ProfileHotel: Identifiable {
    var id = UUID()
    var profileName: String?
    var imageText: String
    var imageUrl: URL?
}

struct CountryProfileView: View {
    @ObservedObject var landMarkViewModel: LandMarkViewModel

    let profileHotel: [ProfileHotel] = [
         ProfileHotel(profileName: "london", imageText: "London"),
         ProfileHotel(profileName: "mumbai", imageText: "India"),
         ProfileHotel(profileName: "newyork", imageText: "New York"),
         ProfileHotel(profileName: "england", imageText: "England"),
         ProfileHotel(profileName: "australia", imageText: "Australia"),
         ProfileHotel(profileName: "germany", imageText: "Germany"),
         ProfileHotel(imageText: "Australia", imageUrl: URL(string: "https://images.trvl-media.com/lodging/1000000/540000/532700/532601/759fd6ad.jpg?impolicy=resizecrop&rw=455&ra=fit")),
         ProfileHotel(imageText: "China", imageUrl: URL(string: "https://images.trvl-media.com/lodging/1000000/880000/872600/872512/d273b663.jpg?impolicy=resizecrop&rw=455&ra=fit"))
     ]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 30){
                ForEach(profileHotel){profilehotel in
                    HotelCardView(showHotel : profilehotel, landMarkViewModel: landMarkViewModel)
                }
            }
            .padding(20)
        }
    }
}
 

struct HotelCardView: View {
    let showHotel: ProfileHotel
    @ObservedObject var landMarkViewModel: LandMarkViewModel

    var body: some View {
        VStack {
            if let imageUrl = showHotel.imageUrl {
                AsyncImage(url: imageUrl) { phase in
                    switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                                .onTapGesture {
                                    landMarkViewModel.fetchLandMarks(countryName: showHotel.imageText)
                                }
                        case .failure(_):
                            Color.gray // Placeholder or error image
                        case .empty:
                            Color.gray // Placeholder or loading image
                    @unknown default:
                        fatalError()
                    }
                }
                .frame(width: 50, height: 50) // Set frame size for AsyncImage
            } else if let localImage = UIImage(named: showHotel.profileName!) {
                SwiftUI.Image(uiImage: localImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    .onTapGesture {
                        landMarkViewModel.fetchLandMarks(countryName: showHotel.imageText)
                    }
            } else {
                Color.gray
            }

            Text(showHotel.imageText)
                .font(.headline)
                .padding(.top, 8)
        }
    }
}

struct CountryProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CountryProfileView(landMarkViewModel: LandMarkViewModel())
    }
}
