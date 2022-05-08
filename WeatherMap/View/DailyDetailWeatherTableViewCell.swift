//
//  DailyDetailWeatherTableViewCell.swift
//  WeatherMap
//
//  Created by QiuFeng on 2022/5/8.
//

import UIKit
import SDWebImage

class DailyDetailWeatherTableViewCell: UITableViewCell {
    
    lazy var descLabel: UILabel = {
        let label = UILabel()
        return label
    } ()
    
    lazy var mainLabel: UILabel = {
        let label = UILabel()
        return label
    } ()

    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    } ()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
    }
    
    func setup() {
        setupIconImageView()
        setupMainLabel()
        setupDescLabel()
    }
    
    func setupIconImageView() {
        contentView.addSubview(iconImageView)
        iconImageView.backgroundColor = UIColor.blue
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
    }
    
    func setupMainLabel() {
        contentView.addSubview(mainLabel)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 15).isActive = true
        mainLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -15).isActive = true
        mainLabel.topAnchor.constraint(equalTo: iconImageView.topAnchor).isActive = true
        mainLabel.bottomAnchor.constraint(greaterThanOrEqualTo: iconImageView.bottomAnchor).isActive = true
    }
    
    func setupDescLabel() {
        contentView.addSubview(descLabel)
        descLabel.numberOfLines = 0
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.leadingAnchor.constraint(equalTo: iconImageView.leadingAnchor).isActive = true
        descLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -15).isActive = true
        descLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 5).isActive = true
        descLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }

    func configurate(_ weather: Weather) {
        mainLabel.text = weather.main
        descLabel.text = weather.desc
        iconImageView.sd_setImage(with: weather.iconUrl)
    }
}
