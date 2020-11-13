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
    
    @IBOutlet weak var firstTimeLabel: UILabel!
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var firstTempLabel: UILabel!
    
    @IBOutlet weak var secondTimeLabel: UILabel!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var secondTempLabel: UILabel!
    
    @IBOutlet weak var thirdTimeLabel: UILabel!
    @IBOutlet weak var thirdImage: UIImageView!
    @IBOutlet weak var thirdTempLabel: UILabel!
    
    @IBOutlet weak var fourthTimeLabel: UILabel!
    @IBOutlet weak var fourthImage: UIImageView!
    @IBOutlet weak var fourthTempLabel: UILabel!
    
    @IBOutlet weak var fifthTimeLabel: UILabel!
    @IBOutlet weak var fifthImage: UIImageView!
    @IBOutlet weak var fifthTempLabel: UILabel!
    
    var locationData: CLLocationManager?
    var currentWeather: CurrentWeather?
    var forecast: Forecast?
    
    var hourlyForecastTemps = [Double]()
    var hourlyForecastCondition = [Int]()
    var hourlyForecastTimes = [Int]()
    var fiveDayForecastTemps = [Double]()
    var fiveDayForecastCondition = [Int]()
    var fiveDayForecastTimes = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        GeoLocation.shared.delegate = self
        GeoLocation.shared.getGPSLocation()
        getCurrentDate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func getWeatherImage(id: Int) -> String {
        switch id {
        case 200...232:
            return "Lightning"
        case 300...321, 500...531:
            return "Rainy"
        case 600...622:
            return "Snow"
        case 800:
            return "Sunny"
        case 801...802:
            return "Partially Cloudy"
        case 803...804:
            return "Cloudy"
        default:
            return "Partially Cloudy"
        }
    }
    
    func getBackgroundColor(id: Int) -> UIColor {
        switch id {
        case 200...232:
            return UIColor(cgColor: #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1))
        case 300...321, 500...531:
            return UIColor(cgColor: #colorLiteral(red: 0.2623462379, green: 0.3999766409, blue: 0.6452640891, alpha: 1))
        case 600...622:
            return UIColor(cgColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        case 800:
            return UIColor(cgColor: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1))
        case 801...802:
            return UIColor(cgColor: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1))
        case 803...804:
            return UIColor(cgColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
        default:
            return UIColor(cgColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
        }
    }
    
    func getCurrentDate() {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = now.dateFormatWithSuffix()
        let datetime = dateFormatter.string(from: now)
        dateLabel.text = datetime
    }
    
    func translateTime(unixDate: Int, forecast: String) -> String {
        let unixTimeInterval = Double(unixDate)
        let date = Date(timeIntervalSince1970: unixTimeInterval)
        let dateFormatter = DateFormatter()
        if forecast == "hourly" {
            dateFormatter.dateFormat = "HH:mm"
        } else {
            dateFormatter.dateFormat = "EE"
        }
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    @IBAction func todayPressed(_ sender: UIButton) {
        if hourlyForecastCondition.count == 0 {
            populateHourlyForecast()
        }
        updateForecast(forecast: "hourly")
        thisWeekButton.titleLabel!.font = UIFont(name: "Avenir Light", size: 20)
        todayButton.titleLabel!.font = UIFont(name: "Avenir Light", size: 26)
    }
    
    @IBAction func thisWeekPressed(_ sender: UIButton) {
        if fiveDayForecastCondition.count == 0 {
            populateFiveDayForecast()
        }
        updateForecast(forecast: "weekly")
        thisWeekButton.titleLabel!.font = UIFont(name: "Avenir Light", size: 26)
        todayButton.titleLabel!.font = UIFont(name: "Avenir Light", size: 20)
    }
    
    func updateForecast(forecast: String) {
        var imageString: String
        let forecastTimeLabels = [firstTimeLabel, secondTimeLabel, thirdTimeLabel, fourthTimeLabel, fifthTimeLabel]
        let forecastImages = [firstImage, secondImage, thirdImage, fourthImage, fifthImage]
        let forecastTempLabels = [firstTempLabel, secondTempLabel, thirdTempLabel, fourthTempLabel, fifthTempLabel]
        for i in 0...4 {
            if forecast == "hourly" {
                forecastTimeLabels[i]!.text = translateTime(unixDate: hourlyForecastTimes[i], forecast: "hourly")
                forecastTempLabels[i]!.text = String(Int(hourlyForecastTemps[i])) + "°"
                imageString = getWeatherImage(id: hourlyForecastCondition[i])
            } else {
                forecastTimeLabels[i]!.text = translateTime(unixDate: fiveDayForecastTimes[i], forecast: "weekly")
                forecastTempLabels[i]!.text = String(Int(fiveDayForecastTemps[i])) + "°"
                imageString = getWeatherImage(id: fiveDayForecastCondition[i])
            }
            forecastImages[i]?.image = UIImage(named: imageString)
        }
    }
    
    func populateFiveDayForecast() {
        guard let forecast = forecast else { return }
        for i in stride(from: 0, to: 39, by: 8) {
            fiveDayForecastTemps.append(forecast.list![i].main.temp)
            fiveDayForecastTimes.append(forecast.list![i].dt)
            fiveDayForecastCondition.append(forecast.list![i].weather![0].id)
        }
    }
    
    func populateHourlyForecast() {
        guard let forecast = forecast else { return }
        for i in stride(from: 0, to: 5, by: 1) {
            hourlyForecastTemps.append(forecast.list![i].main.temp)
            hourlyForecastTimes.append(forecast.list![i].dt)
            hourlyForecastCondition.append(forecast.list![i].weather![0].id)
        }
    }
    
    func getLocationCoords(latitude: String, longitude: String) {
        getCurrentWeather(lat: latitude, long: longitude)
        getForecast(lat: latitude, long: longitude)
    }
    
    func getCurrentWeather(lat: String, long: String) {
        WeatherService.shared.getCurrentWeather(lat: lat, long: long) { [self] (currentWeather) in
            self.currentWeather = currentWeather
            currentTempLabel.text = String(Int((currentWeather.main!.temp))) + "°"
            cityLabel.text = currentWeather.name
            currentConditionsLabel.text = currentWeather.weather![0].description
            currentWeatherImage.image = UIImage(named: getWeatherImage(id: currentWeather.weather![0].id))
            view.backgroundColor = getBackgroundColor(id: currentWeather.weather![0].id)
        } onError: { (err) in
            print(err)
        }
    }
    
    func getForecast(lat: String, long: String) {
        WeatherService.shared.getForecast(lat: lat, long: long) { [self] (forecast) in
            self.forecast = forecast
            populateHourlyForecast()
            updateForecast(forecast: "hourly")
        } onError: { (err) in
            print(err)
        }
    }
}

extension Date {

    func dateFormatWithSuffix() -> String {
        return "EEEE, dd'\(self.daySuffix())' MMM"
    }
    
    func dateFormatDayOfWeek() -> String {
        return "EEEE"
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

   
