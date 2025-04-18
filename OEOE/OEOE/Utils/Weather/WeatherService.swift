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
    let threeHourInterval: TimeInterval = 3 * 3600
    let nextHour = ceil(currentTime / threeHourInterval) * threeHourInterval
    let targetTimes = [0, 1, 2].map { nextHour + (threeHourInterval * Double($0)) }

    var result: [ForecastEntry] = []

    for target in targetTimes {
        if let match = weatherResponse.list.first(where: { abs($0.dt - target) < 60 }) {
            result.append(match)
        }
    }

    return result
}


