//
//  WeatherCardView.swift
//  OEOE
//
//  Created by zeze on 4/19/25.
//

import SwiftUI

struct WeatherCardView: View {
    let entry: ForecastEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(formattedTime(from: entry.dt))
                .font(.headline)
                .foregroundColor(.primary)

            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("🌡️ 기온: \(String(format: "%.1f", entry.main.temp))°C")
                    Text("💧 습도: \(entry.main.humidity)%")
                    Text("☔️ 강수확률: \(Int((entry.pop ?? 0) * 100))%")
                    Text("🌬️ 풍속: \(String(format: "%.1f", entry.wind.speed)) m/s")
                }
                .font(.subheadline)

                Spacer()

                VStack {
                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(entry.weather.first?.icon ?? "01d")@2x.png")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 60, height: 60)

                    Text(entry.weather.first?.description.capitalized ?? "날씨 정보 없음")
                        .font(.caption)
                        .multilineTextAlignment(.center)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(16)
        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
    }

    private func formattedTime(from timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let formatter = DateFormatter()
        formatter.dateFormat = "a h시"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
}
