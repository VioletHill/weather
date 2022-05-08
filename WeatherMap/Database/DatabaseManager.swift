//
//  DatabaseManager.swift
//  WeatherMap
//
//  Created by QiuFeng on 2022/5/8.
//

import UIKit
import FMDB

class DatabaseManager: NSObject {
    var path: URL
    var db: FMDatabase!
    var queue: FMDatabaseQueue!

    let insertSQL = "insert into weather(dt, weather, tempMin, tempMax, lat, lon) VALUES (?, ?, ?, ?, ?, ?)"
    
    static let instance = DatabaseManager()
    override init() {
        path = FileManager.default.documentsDirectory().appendingPathComponent("weather.sqlite")
        print(path)
        db = FMDatabase(url: path)
        queue = FMDatabaseQueue(url: path)
        super.init()
        createTable()
    }

    func createTable() {
        if db.open() {
            queue.inDatabase { db in
                let sql = "create table if not exists weather (dt Double,  weather, tempMin Double, tempMax Double, lat Double, lon Double)"
                db.executeStatements(sql)
            }
            db.close()
        }
    }
    
    func saveDailyWeathers(_ dailyWeathers: [DailyWeather]) {
        defer {
            db.close()
        }
        if db.open() {
            print("start open db")
            queue.inTransaction { db, rollback in
                do {
                    print("start transation")
                    for dailyWeather in dailyWeathers {
                        let weatherData = try? JSONEncoder().encode(dailyWeather.weather)
                        let values = [dailyWeather.dt, weatherData ?? Data(), dailyWeather.temperature.min, dailyWeather.temperature.max,
                                      dailyWeather.lat ?? 0,
                                      dailyWeather.lon ?? 0] as [Any]
                        try db.executeUpdate(insertSQL, values: values)
                    }
                } catch {
                    rollback.pointee = true
                    print(error)
                }
            }
        }
    }
    
    func getFutherDailyWeather(date : Date, lat: Double, lon: Double) -> [DailyWeather] {
        defer {
            db.close()
        }
        var dailyWeathers = [DailyWeather]()
        if db.open() {
            queue.inTransaction { db, rollback in
                do {
                    let time = date.timeIntervalSince1970
                    let result = try db.executeQuery("Select * from weather where dt >= ? and ABS(lat - ?) < 0.01 and ABS(lon - ?) < 0.01 order by dt", values: [time, lat, lon])
                    while (result.next()) {
                        var weather: [Weather]?
                  
                        let weatherData = result.data(forColumn: "weather")
                        if let weatherData = weatherData {
                                weather = try? JSONDecoder().decode([Weather].self, from: weatherData)
                        }
                
                        let temp = WeatherTemp(maxValue: Float(result.double(forColumn: "tempMin")), minValue: Float(result.double(forColumn: "tempMax")))
                        let lat = result.double(forColumn: "lat")
                        let lon = result.double(forColumn: "lon")
                        let dailyWeather = DailyWeather(dt: TimeInterval(result.int(forColumn: "dt")), temperature: temp, weather: weather, lat: lat, lon: lon)
                        dailyWeathers.append(dailyWeather)
                    }
                } catch {
                    rollback.pointee = true
                    print(error)
                }
            }
        }
        return dailyWeathers
    }
}
