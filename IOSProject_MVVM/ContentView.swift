//
//  ContentView.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 11/08/23.
//

import SwiftUI


struct ContentView: View {

//    @EnvironmentObject var settings: UserSettings


    var body: some View {
        NavigationStack{
            SplashView()
//            LandMarkScreenView()
        }

        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
