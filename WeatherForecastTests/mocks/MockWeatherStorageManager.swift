//
//  MockWeatherStorageManager.swift
//  WeatherForecastTests
//
//  Created by Ashish Gour on 19/09/24.
//

import Foundation
@testable import WeatherForecast

class MockWeatherStorageManager: WeatherStorageManager {
    
    private let shouldSetError: Bool
    private let lastFetchTime: Date
    var saveWeatherCalled = false
    var loadWeatherCalled = false
    
    init(shouldSetError: Bool = false, lastFetchTime: Date = Date()) {
        self.shouldSetError = shouldSetError
        self.lastFetchTime = lastFetchTime
    }
    
    func saveWeather(_ weather: WeatherResponse, city: String) {
        saveWeatherCalled = true
    }
    
    func loadWeather(city: String) -> WeatherResponse? {
        guard !shouldSetError, !city.isEmpty else { return nil }
        loadWeatherCalled = true
        return getWeatherDetails(lastFetchTime: lastFetchTime)
    }
    
}
