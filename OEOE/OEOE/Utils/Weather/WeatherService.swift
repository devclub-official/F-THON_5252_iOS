//
//  WeatherResponse.swift
//  OEOE
//
//  Created by zeze on 4/19/25.
//
import Foundation


func fetchWeather(lat: Double, lon: Double, completion: @escaping (Result<[ForecastEntry], Error>) -> Void) {
    let apiKey = "444af1feec0ffe313778b286c76fcbec"
    let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&units=metric&appid=\(apiKey)&lang=kr"

    guard let url = URL(string: urlString) else {
        completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
        return
    }

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }

        guard let data = data else {
            completion(.failure(NSError(domain: "No Data", code: 404, userInfo: nil)))
            return
        }

        do {
            let decoder = JSONDecoder()
            let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
            
            let weatherData = extractWeatherData(from: weatherResponse)
            completion(.success(weatherData))
        } catch {
            completion(.failure(error))
        }
    }
    
    task.resume()
}


func extractWeatherData(from weatherResponse: WeatherResponse) -> [ForecastEntry] {
    let currentTime = Date().timeIntervalSince1970
    let targetOffsets: [TimeInterval] = [3, 6, 9].map { Double($0) * 3600 }
    let margin: TimeInterval = 3600 * 1.5 // ±1.5시간 허용

    var result: [ForecastEntry] = []

    for offset in targetOffsets {

        if let closest = weatherResponse.list.min(by: {
            abs(($0.dt - currentTime) - offset) < abs(($1.dt - currentTime) - offset)
        }), abs((closest.dt - currentTime) - offset) <= margin {
            result.append(closest)
        }
    }

    return result
}

