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
        ScrollView {
            VStack(spacing: 45) {
                Text(viewModel.currentAddress)
                    .font(.headline)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .background(Color.blue.opacity(0.2))

                if let entry = viewModel.forecastEntry.first {
                    WeatherCardView(entry: entry)
                }

                // 추천 코디 리스트
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(viewModel.outfitRecommendations.indices, id: \.self) { index in
                        let outfit = viewModel.outfitRecommendations[index]
                        HStack(spacing: 8) {
                            Text("\(index + 1)위")
                                .bold()
                            ForEach(outfit, id: \.self) { item in
                                Text(item.displayName)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(6)
                            }
                        }
                    }
                }
                .padding(.top, 10)
                
                Spacer()
            }
            .padding()
        }
        

    }
}
