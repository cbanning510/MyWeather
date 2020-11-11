//
//  ViewController.swift
//  MyWeather
//
//  Created by chris on 11/10/20.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, LocationDelegate {
    
    var locationData:CLLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        GeoLocation.shared.delegate = self
        GeoLocation.shared.getGPSLocation()        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        getWeather()
    }
    
    func getLocationCoords(latitude: String, longitude: String) {
        WeatherService.shared.URL_BASE = "https://api.openweathermap.org/data/2.5/onecall?appid=cfd15c260a336ab7559d15b7e1a55d96&lat=\(latitude)&lon=\(longitude)&units=imperial"
        print(WeatherService.shared.URL_BASE)
    }
    
    func getWeather() {
        WeatherService.shared.getWeather { (currentWeather) in
            print("currentWeather.weather: \(currentWeather)")
        } onError: { (err) in
            print(err)
        }

    }
}

   
