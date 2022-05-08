//
//  DailyWeather+DataCenter.swift
//  WeatherMap
//
//  Created by QiuFeng on 2022/5/8.
//

import Foundation

extension DailyWeather {
    static func getCacheData(lat: Double, lon: Double, complete: @escaping ([DailyWeather]?) -> Void) {
        DispatchQueue.global().async {
            let date = Date().startOfDay
            let daily = DatabaseManager.instance.getFutherDailyWeather(date: date, lat: lat, lon: lon).unique { $0.date!.isSameDay(date2: $1.date!) }
            DispatchQueue.main.async {
                complete(daily)
            }
        }
    }
}

