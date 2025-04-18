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
        VStack {
            Text(viewModel.currentAddress)
                .font(.headline)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .background(Color.blue.opacity(0.2))
            if let entry = viewModel.forecastEntry.first {
                WeatherCardView(entry: entry)
            }
       
                 
            Button {
                appState.changeTab(.ai)
            } label: {
                Text("AI에게 옷추천 받기")
                    .foregroundStyle(Color.black)
                  
            }
            .padding()
            .border(Color.blue)
            .background(Color.blue.opacity(0.8))
            .cornerRadius(15)
         
        }     .onAppear {
            viewModel.homeInit()
        }

    }
    
}


