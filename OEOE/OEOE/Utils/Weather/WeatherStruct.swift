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
    let wind: Wind // 풍속
    let pop: Double?  // 강수 확률 (0.0 ~ 1.0)

    struct Main: Codable {
        let temp: Double // 온도
        let humidity: Int // 습도
    }

    struct Weather: Codable {
        let description: String
        let icon: String
    }

    struct Wind: Codable {
        let speed: Double
    }
}
