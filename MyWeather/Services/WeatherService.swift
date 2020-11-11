//
//  WeatherService.swift
//  MyWeather
//
//  Created by chris on 11/11/20.
//

import Foundation

class WeatherService {
    static let shared = WeatherService()
    
    //let URL_BASE = "https://api.openweathermap.org/data/2.5/weather?"
    let URL_BASE = "https://api.openweathermap.org/data/2.5/weather?appid=cfd15c260a336ab7559d15b7e1a55d96&lat=39.7039483&lon=-75.7831014&units=imperial"
    
    let session = URLSession(configuration: .default)
    
    func getWeather(onSuccess: @escaping (CurrentWeather) -> Void, onError: @escaping (String) -> Void) {
        let url = URL(string: "\(URL_BASE)")!
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.sync {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }
                // Create Weather data model!!
                do {
                    if response.statusCode == 200 {
                        let currentWeather = try JSONDecoder().decode(CurrentWeather.self, from: data)
                        print("\ncurrentWeather: \(currentWeather)")
                        onSuccess(currentWeather)
                    } else {
                        let err = try JSONDecoder().decode(APIError.self, from: data)
                        onError(err.message)
                    }
                }
                catch {
                    debugPrint(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
