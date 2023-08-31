//
//  LandMarkScreenView.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 08/08/23.
//

import Foundation
import SwiftUI

struct LandMarkScreenView: View {
    @ObservedObject var landMarkViewModel: LandMarkViewModel = LandMarkViewModel()
    @EnvironmentObject var loginViewModel: LoginViewModel

    var body: some View {
//        NavigationView {
            VStack {
                LandmarkSearchBarView

                switch landMarkViewModel.state {
                        case .success:  LandMarkListView

                        case .dataEmpty:  DataEmptyView

                        case .loading:  LandmarkProgressView

                        case .noTextInput:  NoInputView

                        default:  EmptyView()
                    }

                if case .success = landMarkViewModel.state { }
                else {
                    StaticlandmarkDataView
                }
            }
            .alert(isPresented: $landMarkViewModel.hasError) {
                errorAlert
            }
            .navigationBarBackButtonHidden()
            .navigationTitle("Welcome to Hotels")
            .navigationBarItems(trailing: LogoutButton )
            .navigationBarItems(leading: HomeButton )
//        }
    }
}

struct LandMarkScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LandMarkScreenView()
                    .environmentObject(LoginViewModel())
    }
}







