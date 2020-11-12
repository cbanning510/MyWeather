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
    
    var locationData: CLLocationManager?
    var currentWeather: CurrentWeather?
    var forecast: Forecast?
    var fiveDayForecast = [ThreeHourInterval]()
        // main.temp - temp
        // weather.id - image
        // dt - time
    var currentTime = String()
    var currentTemp = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        GeoLocation.shared.delegate = self
        GeoLocation.shared.getGPSLocation()
        getCurrentDate()
        //configureUI()
    }
    
    func getWeatherImage(id: Int) {
        switch id {
        case 200...232:
            currentWeatherImage.image = UIImage(named: "Lightning")
        case 300...321, 500...531:
            currentWeatherImage.image = UIImage(named: "Rainy")
        case 600...622:
            currentWeatherImage.image = UIImage(named: "Snow")
        case 800:
            currentWeatherImage.image = UIImage(named: "Sunny")
        case 801...802:
            currentWeatherImage.image = UIImage(named: "Partially Cloudy")
        case 803...804:
            currentWeatherImage.image = UIImage(named: "Cloudy")
        default:
            currentWeatherImage.image = UIImage(named: "Partially Cloudy")
        }
    }    
    
    func getCurrentDate() {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = now.dateFormatWithSuffix()
        let datetime = dateFormatter.string(from: now)
        currentTime = datetime
        dateLabel.text = currentTime
    }
    
    @IBAction func todayPressed(_ sender: UIButton) {
        // shows forecast by 2 hour intervals
    }
    
    @IBAction func thisWeekPressed(_ sender: UIButton) {
        // shows forecast for 5 days
    }
    
    func getLocationCoords(latitude: String, longitude: String) {
        getWeather(lat: latitude, long: longitude)
        getForecast(lat: latitude, long: longitude)
    }
    
    func getWeather(lat: String, long: String) {
        WeatherService.shared.getCurrentWeather(lat: lat, long: long) { [self] (currentWeather) in
            self.currentWeather = currentWeather
            currentTempLabel.text = String(Int((currentWeather.main!.temp))) + "°"
            cityLabel.text = currentWeather.name
            currentConditionsLabel.text = currentWeather.weather![0].description
            getWeatherImage(id: currentWeather.weather![0].id)
           //print("currentWeather.weather: \(currentWeather)")
        } onError: { (err) in
            print(err)
        }
    }
    
    func getForecast(lat: String, long: String) {
        WeatherService.shared.getForecast(lat: lat, long: long) { [self] (forecast) in
            self.forecast = forecast
            print("forecast.weather: \(forecast.list![0])")
            print("\ntype of forecast.weather: \(type(of:(forecast.list![0])))")
        } onError: { (err) in
            print(err)
        }
    }
}

extension Date {

    func dateFormatWithSuffix() -> String {
        return "EEEE, dd'\(self.daySuffix())' MMM"
    }

    func daySuffix() -> String {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.day, from: self)
        let dayOfMonth = components.day
        switch dayOfMonth {
        case 1, 21, 31:
            return "st"
        case 2, 22:
            return "nd"
        case 3, 23:
            return "rd"
        default:
            return "th"
        }
    }
}

   
