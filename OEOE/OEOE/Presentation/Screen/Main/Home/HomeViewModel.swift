//
//  HomeViewModel.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    private let locationHelper = LocationHelper()

    @Published var desc: String = ""
    @Published var testData: TestResponse?
    @Published var showLocationAlert = false
    @Published var currentAddress: String = ""
    
    init() {
        locationHelper.startUpdatingLocation { [weak self] location in
            self?.locationHelper.reverseGeocode(location: location) { address in
                DispatchQueue.main.async {
                    self?.currentAddress = address ?? "위치 확인 불가"
//                    self?.loadWeather(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
                }
            }
        }
    }

 
    func loadWeather(lat: Double, lon: Double) {
        fetchWeather(lat: lat, lon: lon) { result in
            switch result {
            case .success(let weatherData):
                for weather in weatherData {
                    let time = Date(timeIntervalSince1970: weather.dt)
                    let temp = weather.main.temp
                    let humidity = weather.main.humidity
                    let description = weather.weather.first?.description ?? "No description"
                    let windSpeed = weather.wind.speed
                    let precipitation = Int((weather.pop ?? 0) * 100) // 소수 → 퍼센트
                    
                    print("🕒 시간: \(time)")
                    print("🌡️ 기온: \(temp)°C, 💧 습도: \(humidity)%")
                    print("🌤️ 날씨: \(description), 🌬️ 풍속: \(windSpeed) m/s")
                    print("☔️ 강수확률: \(precipitation)%\n")
                }
            case .failure(let error):
                print("날씨 데이터를 가져오는 데 실패했습니다: \(error)")
            }
        }
    }
}
