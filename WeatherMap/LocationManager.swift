//
//  LocationManager.swift
//  WeatherMap
//
//  Created by QiuFeng on 2022/5/6.
//

import UIKit
import CoreLocation

enum LocationError: Error {
    case locationauthorizationRestricted
    case locationauthorizationDeny
}

protocol LocationManagerDelegate {
    func locationManager(_ manager: LocationManager, didUpdateLocations location: CLLocation?, cacheLocation: CLLocation?, error: Error?)
}

class LocationManager: NSObject {
    var location: CLLocation?
    var delegate: LocationManagerDelegate?
    
    lazy var locManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.distanceFilter = kCLDistanceFilterNone
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        return manager
    }()
    
    lazy var cacheLocation: CLLocation? = {
        let userDefault = UserDefaults.standard
        let location = userDefault.object(forKey: UserDefaults.CacheLocationKey) as? CLLocation
        return location
    }()
    
    func requestLocation() throws  {
        let authorizationStatus = locManager.authorizationStatus
        locManager.delegate = self
        switch authorizationStatus {
        case .notDetermined:
            locManager.requestWhenInUseAuthorization()
        case .restricted:
            throw LocationError.locationauthorizationRestricted
        case .denied:
            throw LocationError.locationauthorizationDeny
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            print(locManager.location)
            locManager.requestLocation()
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let firstLocation = locations.first {
            print(firstLocation)
            location = firstLocation
        }
        locManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        locManager.stopUpdatingLocation()
    }
}
