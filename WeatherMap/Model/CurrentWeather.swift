//
//  Weather.swift
//  WeatherMap
//
//  Created by QiuFeng on 2022/5/6.
//

import UIKit

class CurrentWeather: NSObject, Codable {
    
    /// Requested time, Unix, UTC
    var dt: TimeInterval
    
    var weather: [Weather]
    
    var temp: Float
    
    enum CodingKeys: String, CodingKey {
        case dt
        case weather
        case temp
    }
}
