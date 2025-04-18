//
//  WeatherStruct.swift
//  OEOE
//
//  Created by zeze on 4/19/25.
//
import Foundation

struct WeatherResponse: Codable {
    let city: City
    let list: [ForecastEntry]
}
struct City: Codable {
    let name: String
    let country: String
}
struct ForecastEntry: Codable, Identifiable {
    var id: UUID { UUID() }

    let dt: TimeInterval
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let pop: Double?

    // ✅ 추가: 문자열 시간 반환
    var dtText: String {
        let date = Date(timeIntervalSince1970: dt)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: date)
    }

    struct Main: Codable {
        let temp: Double
        let humidity: Int
    }

    struct Weather: Codable {
        let description: String
        let icon: String
    }

    struct Wind: Codable {
        let speed: Double
    }
}
