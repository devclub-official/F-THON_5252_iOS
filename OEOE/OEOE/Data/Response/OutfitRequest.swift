//
//  OutfitRequest.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

struct OutfitRequest: Encodable {
    let gender: String
    let age: Int
    let stylePreference: String
    let purpose: String
    let currentLatitude: Double
    let currentLongitude: Double
    let currentLocationName: String
    let destinationLatitude: Double
    let destinationLongitude: Double
    let destinationLocationName: String
    let requestTime: String
    let weather: WeatherBlock
}

struct WeatherBlock: Encodable {
    let current: LocationWeather
    let destination: LocationWeather
}

struct LocationWeather: Encodable {
    let current: WeatherData
    let after3h: WeatherData
    let after6h: WeatherData
    let after9h: WeatherData
}

struct WeatherData: Encodable {
    let time: String
    let temp: Double
    let humidity: Double
    let description: String
    let windSpeed: Double
    let precipitation: Double
}
