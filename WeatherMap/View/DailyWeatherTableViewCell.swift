//
//  DailyWeatherTableViewCell.swift
//  WeatherMap
//
//  Created by QiuFeng on 2022/5/8.
//

import UIKit

class DailyWeatherTableViewCell: UITableViewCell {

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textLabel?.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func configurate(_ dailyWeather: DailyWeather) {
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        textLabel?.text = dateFormatter.string(from: dailyWeather.date!) + "\n\(dailyWeather.temperature.min) ℃ ～ \(dailyWeather.temperature.max) ℃"
    }
}
