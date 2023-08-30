//
//  LoginScreenBackround.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 25/08/23.
//

import Foundation
import SwiftUI

struct LoginScreenBackground: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color("PrimaryBlue"), Color("SecondaryTeal")]),
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

