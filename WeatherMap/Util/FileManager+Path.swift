//
//  FileManager+Path.swift
//  WeatherMap
//
//  Created by QiuFeng on 2022/5/8.
//

import Foundation

extension FileManager {
   
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}
