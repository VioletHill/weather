//
//  NetworkManager.swift
//  WeatherMap
//
//  Created by QiuFeng on 2022/5/6.
//

import UIKit
import Alamofire



class NetworkManager: NSObject {
    
    static let APIKey = "e6d3681dfa46b7741de2dad5a01b02a1"
    
    static let instance = NetworkManager()
    
    func getWeather(lat: Double, lon: Double) {
        let oneCallURL = "https://api.openweathermap.org/data/2.5/onecall"
        var params = ["exclude": "hourly,alerts",
                      "appid": NetworkManager.APIKey,
                      "lat": lat,
                      "lont": lon] as [String : Any]
        let request = AF.request("")
    }
     
}
