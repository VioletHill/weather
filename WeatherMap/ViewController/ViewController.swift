//
//  ViewController.swift
//  WeatherMap
//
//  Created by QiuFeng on 2022/5/6.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    let locationManager = LocationManager()
    var dailyWeather: [DailyWeather] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    let tableView = UITableView(frame: .zero)
    let currentWeatherView = CurrentWeatherView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        refresh()
    }
    
    func getData(lat: Double, lon: Double) {
        if dailyWeather.isEmpty {
            DailyWeather.getCacheData(lat: lat, lon: lon, complete: { data in
                if self.dailyWeather.isEmpty, let data = data {
                    self.dailyWeather = data
                }
            })
        }
        OneCallWeather.getData(lat: lat, lon: lon) { oneCallWeather, error in
            if let oneCallWeather = oneCallWeather {
                self.dailyWeather = oneCallWeather.daily
                self.currentWeatherView.currentWeather = oneCallWeather.current
            } else {
                self.showErrorAlert(error?.localizedDescription)
            }
        }
    }
}

//MARK: - Setup

extension ViewController {
    func setup() {
        setupLocationManager()
        setupCurrentWeatherView()
        setupTableView()
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
    }
    
    func setupCurrentWeatherView() {
        view.addSubview(currentWeatherView)
        currentWeatherView.backgroundColor = UIColor.blue
        currentWeatherView.translatesAutoresizingMaskIntoConstraints = false
        currentWeatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        currentWeatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        currentWeatherView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        currentWeatherView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.red
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DailyWeatherTableViewCell.self, forCellReuseIdentifier: "DailyWeatherTableViewCell")
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: currentWeatherView.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

//MARK: - PrivateMethod

extension ViewController {
    func showAuthorizationFailAlert(_ message: String?) {
        let alertController = UIAlertController(title: "We can't get your location", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(ok)
        if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
            let goToSetting = UIAlertAction(title: "Go to setting", style: .default) { alert in
                UIApplication.shared.open(url)
            }
            alertController.addAction(goToSetting)
        }
        present(alertController, animated: true)
    }
    
    func showErrorAlert(_ message: String?) {
        let alertController = UIAlertController(title: "error", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(ok)
        present(alertController, animated: true)
    }
    
    func refresh() {
        do {
            try locationManager.requestLocation()
        } catch LocationError.locationauthorizationDeny {
            showAuthorizationFailAlert("your location authorization status is deny")
        } catch LocationError.locationauthorizationRestricted {
            showAuthorizationFailAlert("your location authorization status is restricted")
        } catch _ {
        }
    }
}

//MARK: - Action

extension ViewController {
    @IBAction func getLocationBarItemTouchUpInside(_ sender: UIBarButtonItem) {
        refresh()
    }
}

//MARK: - <UITableViewDelegate, UITableViewDataSource>

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dailyWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyWeatherTableViewCell", for: indexPath) as! DailyWeatherTableViewCell
        cell.configurate(self.dailyWeather[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detail = DetailViewController()
        detail.dailyWeather = self.dailyWeather[indexPath.row]
        navigationController?.pushViewController(detail, animated: true)
    }
}


//MARK: - <LocationManagerDelegate>

extension ViewController: LocationManagerDelegate {
    func locationManager(_ manager: LocationManager, didUpdateLocations location: CLLocation?, cacheLocation: CLLocation?, error: Error?) {
        if let currentLocation = location {
            getData(lat: currentLocation.coordinate.latitude, lon: currentLocation.coordinate.longitude)
        } else if let cacheLocation = cacheLocation {
            getData(lat: cacheLocation.coordinate.latitude, lon: cacheLocation.coordinate.longitude)
        } else {
            if self.locationManager.location == nil && self.locationManager.cacheLocation == nil {
                showErrorAlert(error?.localizedDescription)
            }
        }
    }

}
