//
//  ContentView.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 11/08/23.
//

import SwiftUI


struct ContentView: View {

//    @ObservedObject var networkManager = NetworkManager()

    var body: some View {
        LoginScreenView()
//        LandMarkScreenView()
//            if networkManager.isConnected {
//                    HotelListScreenView()
//            } else {
//                Text(networkManager.connectionDescription)
//            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
