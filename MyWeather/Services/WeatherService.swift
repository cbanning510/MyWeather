//
//  WeatherService.swift
//  MyWeather
//
//  Created by chris on 11/11/20.
//

import Foundation

class WeatherService {
    static let shared = WeatherService()
    let session = URLSession(configuration: .default)
    
    func getCurrentWeather(lat: String, long: String, onSuccess: @escaping (CurrentWeather) -> Void, onError: @escaping (String) -> Void) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?appid=cfd15c260a336ab7559d15b7e1a55d96&lat=\(lat)&lon=\(long)&units=imperial")
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            DispatchQueue.main.sync {
                if let error = error {
                    onError("dispatchqueue error: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }
                
                do {
                    if response.statusCode == 200 {
                        let currentWeather = try JSONDecoder().decode(CurrentWeather.self, from: data)
                        onSuccess(currentWeather)
                    } else {
                        let err = try JSONDecoder().decode(APIError.self, from: data)
                        onError("error decoding: \(err.message)")
                    }
                }
                
                catch {
                    debugPrint("debug: \(error)")
                }
            }
        }
        
        task.resume()
    }
    
    func getForecast(lat: String, long: String, onSuccess: @escaping (Forecast) -> Void, onError: @escaping (String) -> Void) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?appid=cfd15c260a336ab7559d15b7e1a55d96&lat=\(lat)&lon=\(long)&units=imperial")
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            DispatchQueue.main.sync {
                if let error = error {
                    onError("dispatchqueue error: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }
                
                do {
                    if response.statusCode == 200 {
                        let forecast = try JSONDecoder().decode(Forecast.self, from: data)
                        onSuccess(forecast)
                    } else {
                        let err = try JSONDecoder().decode(APIError.self, from: data)
                        onError("error decoding: \(err.message)")
                    }
                }
                
                catch {
                    debugPrint("debug: \(error)")
                }
            }
        }
        
        task.resume()
    }
}
