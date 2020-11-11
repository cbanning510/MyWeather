//
//  WeatherService.swift
//  MyWeather
//
//  Created by chris on 11/11/20.
//

import Foundation

//let notificationKey = "com.chrisbanning/location"

class WeatherService {
    static let shared = WeatherService()
    
    var URL_BASE = ""
    
    let session = URLSession(configuration: .default)
    
    func getWeather(onSuccess: @escaping (CurrentWeather) -> Void, onError: @escaping (String) -> Void) {
        let url = URL(string: "\(URL_BASE)")!
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
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
}