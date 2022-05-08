//
//  BaseNetwork.swift
//  WeatherMap
//
//  Created by QiuFeng on 2022/5/6.
//

import UIKit
import Alamofire


class BaseNetwork: NSObject {
    
    static let APIKey = "e6d3681dfa46b7741de2dad5a01b02a1"
    
    static func addApiKeyToParams(_ params: inout [String: Any]) {
        params["appid"] = BaseNetwork.APIKey
    }
     
}
