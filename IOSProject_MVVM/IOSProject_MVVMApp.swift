//
//  IOSProject_MVVMApp.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 08/08/23.
//

import SwiftUI

@main
struct IOSProject_MVVMApp: App {

        var body: some Scene {
            WindowGroup {
                ContentView()
                    .environmentObject(UserSettings())

            }
        }
}
