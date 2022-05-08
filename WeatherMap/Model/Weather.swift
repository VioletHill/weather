//
//  Weather.swift
//  WeatherMap
//
//  Created by QiuFeng on 2022/5/7.
//

import UIKit

//"id": 500,
//"main": "Rain",
//"description": "light rain",
//"icon": "10d"

class Weather: NSObject, Codable {
    var conditionId: Int
    var main: String
    var desc: String
    var iconUrl: URL? {
        get {
            return URL(string: "http://openweathermap.org/img/wn/\(self.icon)@2x.png")
        }
    }
    
    /// For code 500 - light rain icon = "10d". See below a full list of codes
    /// URL is http://openweathermap.org/img/wn/10d@2x.png
    var icon: String
    
    enum CodingKeys: String, CodingKey {
        case conditionId = "id"
        case main
        case desc = "description"
        case icon
    }
    
    init(conditionId: Int, main: String?, desc: String?, icon: String?) {
        self.conditionId = conditionId
        self.main = main ?? ""
        self.desc = desc ?? ""
        self.icon = icon ?? ""
    }
}
