//
//  OneCallWeather.swift
//  WeatherMap
//
//  Created by QiuFeng on 2022/5/8.
//

import Foundation

class OneCallWeather: NSObject, Codable {
    var lat: Double
    var lon: Double
    var timezone: String?
    var timezoneOffset: Int?
    var daily: [DailyWeather]
    var current: CurrentWeather?
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lon
        case timezone
        case timezoneOffset = "timezone_offset"
        case daily
        case current
    }
}
