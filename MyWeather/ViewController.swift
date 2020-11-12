//
//  ViewController.swift
//  MyWeather
//
//  Created by chris on 11/10/20.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, LocationDelegate {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var currentConditionsLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var thisWeekButton: UIButton!
    
    @IBOutlet weak var hour0TimeLabel: UILabel!
    @IBOutlet weak var Hour0Image: UIImageView!
    @IBOutlet weak var Hour0TempLabel: UILabel!
    
    @IBOutlet weak var hour2TimeLabel: UILabel!
    @IBOutlet weak var Hour2Image: UIImageView!
    @IBOutlet weak var Hour2TempLabel: UILabel!
    
    @IBOutlet weak var hour4TimeLabel: UILabel!
    @IBOutlet weak var Hour4Image: UIImageView!
    @IBOutlet weak var Hour4TempLabel: UILabel!
    
    @IBOutlet weak var hour6TimeLabel: UILabel!
    @IBOutlet weak var Hour6Image: UIImageView!
    @IBOutlet weak var Hour6TempLabel: UILabel!
    
    @IBOutlet weak var hour8TimeLabel: UILabel!
    @IBOutlet weak var Hour8Image: UIImageView!
    @IBOutlet weak var Hour8TempLabel: UILabel!
    
    var locationData:CLLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        GeoLocation.shared.delegate = self
        GeoLocation.shared.getGPSLocation()
        getWeather()
    }
    
    @IBAction func todayPressed(_ sender: UIButton) {
    }
    
    @IBAction func thisWeekPressed(_ sender: UIButton) {
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

   
