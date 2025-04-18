//
//  HomeViewModel.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    
    @Published var desc: String = ""
    @Published var testData: TestResponse?
    @Published var showLocationAlert = false
    
    var locationService = LocationService()
    
    init() {
        fetchWeatherDataWithCurrentLocation()
        fetchTestData()
    }
    
    func fetchWeatherDataWithCurrentLocation() {
        locationService.requestLocation { coordinate in
            print("coordinate: \(coordinate)")
            
            getKoreanCityName(lat: coordinate.latitude, lon: coordinate.longitude) { result in
                print("도시 이름: \(String(describing: result))")
                if let result = result {
                    self.desc = result
                }else{
                self.desc = "서울특별시"
                    // 없으면 다시 도시 위치를 요청하기
                }
               
            }
            
            fetchWeather(lat: coordinate.latitude, lon: coordinate.longitude) { result in
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
        desc = "HOME"
    }
    
    private func fetchTestData() {
        Task {
            let data = await apiTest()
            await MainActor.run {
                testData = data
            }
        }
    }
    
    func apiTest() async -> TestResponse? {
        do {
            let response: Response<TestResponse> = try await APIClient.shared.requestDecodable(
                endpoint: .api01,
                method: .post,
                parameters: [
                    "params": "aa"
                ]
            )
            return response.data
        } catch {
            Log.error(#function, error.localizedDescription)
            return nil
        }
    }
}
