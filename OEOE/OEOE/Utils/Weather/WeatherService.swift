//
//  WeatherResponse.swift
//  OEOE
//
//  Created by zeze on 4/19/25.
//
import Foundation


struct WeatherResponse: Codable {
    let timezoneOffset: Int?
    let hourly: [HourlyWeather]

    enum CodingKeys: String, CodingKey {
        case timezoneOffset = "timezone_offset"
        case hourly
    }
}

struct HourlyWeather: Codable, Identifiable {
    var id = UUID()
    let dt: TimeInterval
    let temp: Double // 기온
    let weather: [WeatherDetail]
    
    struct WeatherDetail: Codable {
        let description: String // 설명 약한 비 등등
        let icon: String  // 날씨 아이콘 // https://openweathermap.org/img/wn/{icon_code}.png
    }
}
