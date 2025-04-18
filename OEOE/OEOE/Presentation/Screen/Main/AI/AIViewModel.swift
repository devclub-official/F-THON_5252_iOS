//
//  AIViewModel.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

import SwiftUI
import CoreLocation

final class AIViewModel: ObservableObject {
    private let locationHelper = LocationHelper()

    @Published var currentAddress: String = "현재 위치를 불러오는 중..."
    @Published var destinationAddress: String = ""
    @Published var onboardingData: OnboardingData?
    
    @Published var lookDescription: String = ""
    @Published var lookOptions: [[String]] = []
    @Published var selectedLookIndex: Int? = nil
    @Published var purpose: String = "일상"
    var currentLocation: CLLocationCoordinate2D? = nil

    init() {
        locationHelper.startUpdatingLocation { [weak self] location in
            self?.currentLocation = location.coordinate
            self?.locationHelper.reverseGeocode(location: location) { address in
                DispatchQueue.main.async {
                    self?.currentAddress = address ?? "위치 확인 불가"
                }
            }
        }
        onboardingData = UserDataManager.shared.loadOnboardingData()
    }

    func setDestination(from coordinate: CLLocationCoordinate2D) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        locationHelper.reverseGeocode(location: location) { [weak self] address in
            DispatchQueue.main.async {
                self?.destinationAddress = address ?? "서울특별시 역삼로 179"
            }
            
            
            self?.fetchLooks(coordinate)
        }
    }
    
    func convertToWeatherData(_ entry: ForecastEntry) -> WeatherData {
        return WeatherData(
            time: entry.dtText,
            temp: entry.main.temp,
            humidity: Double(entry.main.humidity),
            description: entry.weather.first?.description ?? "정보 없음",
            windSpeed: entry.wind.speed,
            precipitation: (entry.pop ?? 0) * 100
        )
    }
    
    func fetchLooks(_ destinationData: CLLocationCoordinate2D) {
        guard let currentLocation else { return }

        Task {
            do {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let requestTime = formatter.string(from: Date())

                // ✅ 날씨 비동기로 요청
                async let currentForecast = fetchWeatherAsync(lat: currentLocation.latitude, lon: currentLocation.longitude)
                async let destinationForecast = fetchWeatherAsync(lat: destinationData.latitude, lon: destinationData.longitude)
                

                let current = try await currentForecast
                let destination = try await destinationForecast

                guard current.count >= 4, destination.count >= 4 else {
                    print("❌ 예보 데이터 부족")
                    return
                }

                // ✅ WeatherBlock 생성
                let weatherBlock = WeatherBlock(
                    current: LocationWeather(
                        current: convertToWeatherData(current[0]),
                        after3h: convertToWeatherData(current[1]),
                        after6h: convertToWeatherData(current[2]),
                        after9h: convertToWeatherData(current[3])
                    ),
                    destination: LocationWeather(
                        current: convertToWeatherData(destination[0]),
                        after3h: convertToWeatherData(destination[1]),
                        after6h: convertToWeatherData(destination[2]),
                        after9h: convertToWeatherData(destination[3])
                    )
                )

                // OutfitRequest 구성
                let request = OutfitRequest(
                    gender: gender(),
                    age: Int(onboardingData?.age ?? "") ?? 20,
                    stylePreference: onboardingData?.style ?? "캐주얼",
                    purpose: purpose,
                    currentLatitude: currentLocation.latitude,
                    currentLongitude: currentLocation.longitude,
                    currentLocationName: currentAddress,
                    destinationLatitude: destinationData.latitude,
                    destinationLongitude: destinationData.longitude,
                    destinationLocationName: destinationAddress,
                    requestTime: requestTime,
                    weather: weatherBlock
                )

                // API 호출
                let response: LookResponse = try await APIClient.shared.requestDecodable(
                    endpoint: .postOutfitRequest,
                    method: .post,
                    body: request
                )

                // 결과 반영
                await MainActor.run {
                    self.lookDescription = response.description
                    self.lookOptions = response.clothes.map {
                        $0.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
                    }
                }

            } catch {
                Log.error(#function, error.localizedDescription)
            }
        }
    }

    
    func postPopularLook() {
        Task {
            do {
                guard let selectedIndex = selectedLookIndex else { return }
                let selectedDisplayNames = lookOptions[selectedIndex]
                let selectedCodeList: [String] = selectedDisplayNames.compactMap {
                    ClothingType.fromDisplayName($0)?.rawValue
                }
                
                let request = OutfitRecommendationRequest(
                    gender: gender(),
                    location: destinationAddress,
                    code: selectedCodeList
                )

                print("OK!~~~~~~~~ \(selectedCodeList)")
                
            } catch {
                Log.error(#function, error.localizedDescription)
            }
        }
    }
    
    func gender() -> String {
        switch onboardingData?.gender ?? "여자" {
        case "남자":
            return "male"
        case "여자":
            return "female"
        default:
            return "female"
        }
    }
}
