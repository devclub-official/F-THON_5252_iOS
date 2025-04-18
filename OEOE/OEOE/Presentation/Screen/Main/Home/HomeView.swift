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
                .foregroundStyle(Color.red)
            Text("현재 시각").font(.subheadline)
            Text("2025-04-19 03:00").font(.subheadline)
            VStack(alignment: .leading, spacing: 16) {
                Text("📍 현재 위치 기준")
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 8)

                ForEach(forecasts.prefix(3), id: \forecasts.first.dt) { forecast in
                    WeatherCardView(forecast: forecast)
                }
            }
            .padding()
            
            Button {
                appState.changeTab(.ai)
            } label: {
                Text("AI 탭으로")
                    .foregroundStyle(Color.black)
            }
            .padding()
            .border(Color.red)
         
        }
    }
    
}



struct WeatherCardView: View {
    let forecast: ForecastEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("🕒 \(formattedTime(from: forecast.dt))")
                .font(.headline)

            Text("🌡️ 기온: \(String(format: "%.1f", forecast.main.temp))°C, 💧 습도: \(forecast.main.humidity)%")
            Text("🌤️ 날씨: \(forecast.weather.first?.description ?? "정보 없음")")
            Text("🌬️ 풍속: \(String(format: "%.1f", forecast.wind.speed)) m/s, ☔️ 강수확률: \(Int((forecast.pop ?? 0) * 100))%")
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(radius: 2)
    }

    func formattedTime(from timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let formatter = DateFormatter()
        formatter.dateFormat = "a h시"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
}
