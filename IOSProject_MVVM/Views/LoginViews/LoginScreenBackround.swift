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
        Color("Color").opacity(0.8)
            .ignoresSafeArea()
        Circle()
            .scale(1.7)
            .foregroundColor(.white.opacity(0.15))
        Circle()
            .scale(1.35)
            .foregroundColor(.white)
    }
}
