//
//  ViewController.swift
//  MyWeather
//
//  Created by chris on 11/10/20.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, LocationDelegate {
    
    var latitude: String!
    var longitude: String!
    let apikey = "cfd15c260a336ab7559d15b7e1a55d96"
    var BASE_URL = "https://api.openweathermap.org/data/2.5/weather?"
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        BASE_URL += "lat=\(latitude!)&lon=\(longitude!)&appid=\(apikey)"
        print(BASE_URL)
    }
    
    func getWeather(latitude: String, longitude: String) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    var locationData:CLLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        GeoLocation.shared.delegate = self
        GeoLocation.shared.getGPSLocation()
    }
}

   
