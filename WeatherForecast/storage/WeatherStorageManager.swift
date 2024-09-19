//
//  CurrencyStorageManager.swift
//  CurrencyConverter
//
//  Created by Ashish Gour on 17/09/24.
//

import Foundation

protocol WeatherStorageManager {
    
    func saveWeather(_ weather: WeatherResponse, city: String)
    func loadWeather(city: String) -> WeatherResponse?
}

class WeatherStorage: WeatherStorageManager {
    
    private var userDefaults = UserDefaults.standard
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    func saveWeather(_ weather: WeatherResponse, city: String) {
        
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(weather) {
            userDefaults.set(encoded, forKey: city.lowercased())
        }
    }
    
    func loadWeather(city: String) -> WeatherResponse? {
        
        let decoder = JSONDecoder()
        
        if let savedData = userDefaults.data(forKey: city.lowercased()) {
            if let loadWeather = try? decoder.decode(WeatherResponse.self, from: savedData) {
                return loadWeather
            }
        }
        return nil
    }
    
}
