//
//  HomeView.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @StateObject var viewModel: HomeViewModel

    var body: some View {
        VStack(spacing: 30) {
            Text(viewModel.desc)
                .font(.headline)
                .foregroundStyle(Color.red)
            
            
            Button {
                appState.changeTab(.ai)
            } label: {
                Text("AI 탭으로")
                    .foregroundStyle(Color.black)
            }
            .padding()
            .border(Color.red)
         
        }
        .onAppear {
            
            //locationManager.locationManager.requestWhenInUseAuthorization()
        }
    }
    
}


