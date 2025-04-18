//
//  HomeViewModel.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
     let locationHelper = LocationHelper()

    @Published var desc: String = ""
    @Published var testData: TestResponse?
    @Published var showLocationAlert = false
    @Published var currentAddress: String = ""
    @Published var forecastEntry: [ForecastEntry] = []
    
    init() {
        homeInit()
    }

    
    func homeInit(){
        locationHelper.startUpdatingLocation { [weak self] location in
            self?.locationHelper.reverseGeocode(location: location) { address in
                DispatchQueue.main.async {
                    self?.currentAddress = address ?? "위치 확인 불가"
                    self?.loadWeather(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
                }
            }
        }
    }
 
    func loadWeather(lat: Double, lon: Double) {
        fetchWeather(lat: lat, lon: lon) { result in
            switch result {
            case .success(let weatherData):
                for weather in weatherData {
                    self.forecastEntry.append(weather)
                }
            case .failure(let error):
                print("날씨 데이터를 가져오는 데 실패했습니다: \(error)")
            }
        }
    }
}
