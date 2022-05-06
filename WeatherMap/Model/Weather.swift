//
//  Weather.swift
//  WeatherMap
//
//  Created by QiuFeng on 2022/5/6.
//

import UIKit

class Weather: NSObject, Codable {
    
    /// Requested time, Unix, UTC
    var dt: TimeInterval
    
    /// Sunrise time, Unix, UTC
    var sunrise: TimeInterval
    
    /// Sunset time, Unix, UTC
    var sunset: TimeInterval
    
    /// Temperature. Units – default: kelvin, metric: Celsius, imperial: Fahrenheit.
    var temp: String
    
    enum CodingKeys: String, CodingKey {
        case dt
        case sunrise
        case sunset
        case temp
    }
}
