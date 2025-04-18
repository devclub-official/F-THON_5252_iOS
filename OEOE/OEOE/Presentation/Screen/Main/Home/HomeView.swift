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
            Text(viewModel.currentAddress)
                .font(.headline)
//            Text("현재 시각").font(.subheadline)
            VStack {
                if let entry = viewModel.forecastEntry.first {
                    WeatherCardView(entry: entry)
                }
            }
            .onAppear {

                viewModel.homeInit()
            }

                 
            Button {
                appState.changeTab(.ai)
            } label: {
                Text("AI에게 옷추천 받기")
                    .foregroundStyle(Color.black)
            }
            .padding()
            .border(Color.red)
         
        }
    }
    
}


