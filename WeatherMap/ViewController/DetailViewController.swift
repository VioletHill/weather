//
//  DetailViewController.swift
//  WeatherMap
//
//  Created by QiuFeng on 2022/5/8.
//

import UIKit

class DetailViewController: UIViewController {

    lazy var descLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var dailyWeather: DailyWeather!
    
    var tableView: UITableView = UITableView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "detail"
        setup()
        // Do any additional setup after loading the view.
    }
    
    func setup() {
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DailyDetailWeatherTableViewCell.self, forCellReuseIdentifier: "DailyDetailWeatherTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dailyWeather.weather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyDetailWeatherTableViewCell", for: indexPath) as! DailyDetailWeatherTableViewCell
        cell.configurate(self.dailyWeather.weather[indexPath.row])
        return cell
    }
}
