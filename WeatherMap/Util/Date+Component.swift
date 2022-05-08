//
//  Date+Component.swift
//  WeatherMap
//
//  Created by QiuFeng on 2022/5/8.
//

import Foundation

extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    func isSameDay(date2: Date) -> Bool {
        let diff = Calendar.current.dateComponents([.day], from: self, to: date2)
        if diff.day == 0 {
            return true
        } else {
            return false
        }
    }
}
