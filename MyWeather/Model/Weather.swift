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

struct ThreeHourMain: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let sea_level: Int
    let grnd_level: Int
    let pressure: Double
    let humidity: Double
    let temp_kf: Double
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
    let humidity: Double
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}

struct Rain: Codable {
    let lh: Double?
}

struct Clouds: Codable {
    let all: Int
}

struct Sys: Codable {
    let type: Int?
    let id: Int?
    let country: String
    let sunrise: Int
    let sunset: Int
}

struct ThreeHourSys: Codable {
    let pod: String
}

struct CurrentWeather: Codable {
    let coord: Coord?
    let weather: Array<Weather>?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let rain: Rain?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let timezone: Int?
    let id: Int?
    let name: String?
    let cod: Int?
}

struct ThreeHourInterval: Codable {
    let dt: Int
    let main: ThreeHourMain
    let weather: Array<Weather>?
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let sys: ThreeHourSys?
    let dt_txt: String    
}

struct Forecast: Codable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [ThreeHourInterval]?
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
   // let rain: Rain?
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
    let lon: Double?
    let lat: Double?
}

struct Base: Codable {
    let base: String
}
