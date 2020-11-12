//
//  Weather.swift
//  MyWeather
//
//  Created by chris on 11/11/20.
//

import Foundation

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct CurrentWeather: Codable {
    let lat: Double
    let lon: Double
    let timezone: String
    let timezone_offset: Int
    let current: Current
    let minutely: Array<Minute>
    let hourly: Array<Hourly>?
    let daily: Array<Daily>?
}

struct Minute: Codable {
    let dt: Int
    let precipitation: Double
}

struct Current: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
    let dew_point: Double
    let uvi: Double
    let clouds: Int
    let visibility: Int
    let wind_speed: Double
    let wind_deg: Int
    let weather: Array<Weather>
    let rain: Rain?
}

struct Rain: Codable {
    let lh: Double?
}

struct Hourly: Codable {
    let dt: Int
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
    let dew_point: Double
    let clouds: Int
    let visibility: Int
    let wind_speed: Double
    let wind_deg: Int
    let weather: Array<Weather>
    let pop: Double?
}

struct Daily: Codable { // line 1039
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Temp
    let feels_like: Feels_Like
    let pressure: Int
    let humidity: Int
    let dew_point: Double
    let wind_speed: Double
    let wind_deg: Int
    let weather: Array<Weather>
    let clouds: Int
    let pop: Double?
    let uvi: Double
}

struct Feels_Like: Codable {
    let day: Double
    let night: Double
    let eve: Double
    let morn: Double
}
    
struct Temp: Codable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
}
    
struct Coord: Codable {
    let lon: Double
    let lat: Double
}

struct Base: Codable {
    let base: String
}
