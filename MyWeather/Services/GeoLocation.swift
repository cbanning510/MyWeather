//
//  GeoLocation.swift
//  MyWeather
//
//  Created by chris on 11/10/20.
//

import UIKit
import CoreLocation

protocol LocationDelegate {
    func getWeather(latitude: String, longitude: String)
}

class GeoLocation: UIViewController, CLLocationManagerDelegate {    
    static let shared = GeoLocation()
    var delegate: LocationDelegate?
    
    var locationManager:CLLocationManager!
    var currentLat: CLLocationDegrees!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getGPSLocation()
    }
    
    func getLatitude(completion: @escaping (_ lat: CLLocationDegrees) -> Void) {
        if let currentLat = currentLat {
            completion(currentLat)
        }
    }
    
    func getGPSLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        let lat = String(format: "%.7f", location.coordinate.latitude)
        let long = String(format: "%.7f", location.coordinate.longitude)
        
        manager.stopUpdatingLocation()
    
        delegate?.getWeather(latitude: lat, longitude: long)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
}

