//
//  OneCallWeather+DataCenter.swift
//  WeatherMap
//
//  Created by QiuFeng on 2022/5/8.
//

import Foundation
import UIKit
import Alamofire

extension OneCallWeather {
    
    fileprivate static func request(lat: Double, lon: Double, complete:  @escaping  (OneCallWeather?, Error?) -> Void) {
        let oneCallURL = "https://api.openweathermap.org/data/2.5/onecall"
        var params = ["exclude": "minutely,hourly,alerts",
                      "lat": lat,
                      "lon": lon,
                      "units": "metric"] as [String : Any]
        BaseNetwork.addApiKeyToParams(&params)
        AF.request(oneCallURL, parameters: params).validate().responseDecodable(of: OneCallWeather.self) { response in
                complete(response.value, response.error)
        }
    }
    
    class func getData(lat: Double, lon: Double,
                        networkComplete: @escaping (OneCallWeather?, Error?) -> Void) {
                
        OneCallWeather.request(lat: lat, lon: lon) { oneCallWeather, error in
            if let oneCallWeather = oneCallWeather {
                for daily in oneCallWeather.daily {
                    daily.lon = oneCallWeather.lon
                    daily.lat = oneCallWeather.lat
                }
                DatabaseManager.instance.saveDailyWeathers(oneCallWeather.daily)
            }
            networkComplete(oneCallWeather, error)
        }
    }
}
