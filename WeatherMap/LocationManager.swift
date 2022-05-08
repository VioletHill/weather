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
    
    var _cacheLocation: CLLocation?
    var cacheLocation: CLLocation? {
        get {
            if (_cacheLocation != nil) {
                return _cacheLocation
            }
            let userDefault = UserDefaults.standard
            _cacheLocation = CLLocation(latitude: userDefault.double(forKey: UserDefaults.CacheLocationLatKey), longitude: userDefault.double(forKey: UserDefaults.CacheLocationLonKey))
            return _cacheLocation
        }
        
        set {
            _cacheLocation = newValue
            let userDefault = UserDefaults.standard
            userDefault.set(_cacheLocation?.coordinate.longitude, forKey: UserDefaults.CacheLocationLonKey)
            userDefault.set(_cacheLocation?.coordinate.latitude, forKey: UserDefaults.CacheLocationLatKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    func requestLocation() throws  {
        let authorizationStatus = locManager.authorizationStatus
        locManager.delegate = self
        switch authorizationStatus {
        case .notDetermined:
            locManager.requestWhenInUseAuthorization()
            locManager.requestLocation()
        case .restricted:
            throw LocationError.locationauthorizationRestricted
        case .denied:
            throw LocationError.locationauthorizationDeny
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            locManager.requestLocation()
        @unknown default: break
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let firstLocation = locations.first {
            print(firstLocation)
            location = firstLocation
            self.cacheLocation = firstLocation
            self.delegate?.locationManager(self, didUpdateLocations: location, cacheLocation: location, error: nil)
            locManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        self.delegate?.locationManager(self, didUpdateLocations: nil, cacheLocation: cacheLocation, error: nil)
        locManager.stopUpdatingLocation()
    }
}
