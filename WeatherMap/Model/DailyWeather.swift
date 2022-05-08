//
//  DailyWeather.swift
//  WeatherMap
//
//  Created by QiuFeng on 2022/5/8.
//

import UIKit

class DailyWeather: NSObject, Codable {
    var lat: Double?
    var lon: Double?
    var dt: TimeInterval
    var temperature: WeatherTemp
    var weather: [Weather]
    var date:Date? {
        get {
            return Date(timeIntervalSince1970: self.dt)
        }
    }

    enum CodingKeys: String, CodingKey {
        case dt
        case temperature = "temp"
        case weather
        case lat
        case lon
    }
    
    init(dt: TimeInterval, temperature: WeatherTemp, weather: [Weather]?, lat: Double?, lon: Double?) {
        self.dt = dt
        self.temperature = temperature
        self.weather = weather ?? []
        self.lat = lat
        self.lon = lon
    }
}
