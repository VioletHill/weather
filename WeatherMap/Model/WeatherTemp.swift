//
//  WeatherTemp.swift
//  WeatherMap
//
//  Created by QiuFeng on 2022/5/8.
//

import UIKit

class WeatherTemp: NSObject, Codable {
    
    var min: Float
    var max: Float
    
    enum CodingKeys: String, CodingKey {
        case min
        case max
    }

    init(maxValue: Float, minValue: Float) {
        self.min = minValue
        self.max = maxValue
    }
}
