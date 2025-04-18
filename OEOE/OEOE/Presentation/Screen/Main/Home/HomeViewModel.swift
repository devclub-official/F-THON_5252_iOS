//
//  HomeViewModel.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
     let locationHelper = LocationHelper()

    @Published var showLocationAlert = false
    @Published var currentAddress: String = ""
    @Published var forecastEntry: [ForecastEntry] = []
    @Published var outfitRecommendations: [[ClothingType]] = []
    @Published var onboardingData: OnboardingData?

    
    func homeInit(){
        onboardingData = UserDataManager.shared.loadOnboardingData()
        locationHelper.startUpdatingLocation { [weak self] location in
            self?.locationHelper.reverseGeocode(location: location) { address in
                DispatchQueue.main.async {
                    self?.currentAddress = address ?? "위치 확인 불가"
                    self?.loadWeather(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
                    Task {
                        await self?.getPopularLook()
                    }
                }
            }
        }
        
        
    }
 
    func loadWeather(lat: Double, lon: Double) {
        fetchWeather(lat: lat, lon: lon) { result in
            switch result {
            case .success(let weatherData):
                for weather in weatherData {

                    DispatchQueue.main.async(execute: {
                        self.forecastEntry.append(weather)
                    })
                    
                }
            case .failure(let error):
                print("날씨 데이터를 가져오는 데 실패했습니다: \(error)")
            }
        }
    }
    
    
    func getPopularLook() async {
        do {
            let response: [String] = try await APIClient.shared.requestDecodable(
                endpoint: .getPopularLook,
                method: .get,
                body: Optional<EmptyBody>.none,
                parameters: [
                    "gender" : gender(),
                    "location" : currentAddress
                ]
            )
            await MainActor.run {
                self.outfitRecommendations = self.parseRecommendationResponse(response)
            }
        } catch {
            Log.error(#function, error.localizedDescription)
        }
    }
    
    func parseRecommendationResponse(_ rawResponse: [String]) -> [[ClothingType]] {
        return rawResponse.map { row in
            row
                .split(separator: ",")
                .map { $0.trimmingCharacters(in: .whitespaces) }
                .compactMap { ClothingType(rawValue: $0) }
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
