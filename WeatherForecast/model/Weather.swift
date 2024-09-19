//
//  Weather.swift
//  WeatherForecast
//
//  Created by Ashish Gour on 18/09/24.
//

import Foundation

struct WeatherResponse: Codable {
    var current: CurrentWeather?
    var forecast: Forecast?
    var lastFetchTime: Date?
}

struct Forecast : Codable {
    var forecastday : [Forecastday]?

}

struct CurrentWeather: Codable {
    var temp_c: Double?
    var wind_kph: Double?
    var humidity: Int?
    var feelslike_c: Double?
    var condition: Condition?
    
}

struct Condition: Codable {
    var text: String?
    var icon: String?
    var code: Int?
    
}

struct Day: Codable {
    var maxtemp_c: Double?
    var mintemp_c: Double?
    var maxwind_kph: Double?
    var avghumidity: Int?
    var condition: Condition?
    
}


struct Forecastday: Codable, Identifiable {
    let id = UUID()
    var day: Day?
    var date: String?
    
}
