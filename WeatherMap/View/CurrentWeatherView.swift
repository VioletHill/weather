//
//  CurrentWeatherView.swift
//  WeatherMap
//
//  Created by QiuFeng on 2022/5/8.
//

import UIKit

class CurrentWeatherView: UIView {

    var currentWeather: CurrentWeather! {
        didSet {
            self.label.text = "Current Weather \n \(self.currentWeather.temp) ℃"
        }
    }
    var label: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        label.numberOfLines = 0
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }

}
