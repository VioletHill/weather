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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        let data = "{\"dt\": 1586468027,\"sunrise\": 1586487424,\"sunset\": 1586538297,\"temp\": \"274.31\"}".data(using: .utf8)!
        do {
            let weather = try JSONDecoder().decode(Weather.self, from: data)
            print(weather)
        } catch let e {
            print(e)
        }
      
        // Do any additional setup after loading the view.
    }
    
}

//MARK: - Setup

extension ViewController {
    func setup() {
        setupLocationManager()
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
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
}

//MARK: - Action

extension ViewController {
    @IBAction func getLocationBarItemTouchUpInside(_ sender: UIBarButtonItem) {
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


//MARK: - LocationManagerDelegate

extension ViewController: LocationManagerDelegate {
    func locationManager(_ manager: LocationManager, didUpdateLocations location: CLLocation?, cacheLocation: CLLocation?, error: Error?) {
        if let currentLocation = location {
            
        } else {
            
        }
    }

}
