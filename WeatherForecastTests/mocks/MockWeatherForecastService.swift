//
//  MockCurrencyConverterService.swift
//  CurrencyConverterTests
//
//  Created by Ashish Gour on 17/09/24.
//

import Foundation
import Combine
@testable import WeatherForecast

class MockWeatherForecastService: WeatherForcastService {
    
    private let shouldSetError: Bool
    var fetchWeatherDetailsCalled = false
    
    init(shouldSetError: Bool = false) {
        self.shouldSetError = shouldSetError
    }
    
    func fetchWeather(for city: String) -> AnyPublisher<WeatherResponse, Error> {
        fetchWeatherDetailsCalled = true
        guard !shouldSetError else {
            return Fail(error: NetworkError.someThingWentWrong)
                .eraseToAnyPublisher()
        }
        
        let details = getWeatherDetails()
        return Just(details)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        
    }
}

enum NetworkError: Error {
    case someThingWentWrong
}

func getWeatherDetails() -> WeatherResponse {
    let condition = Condition(text: "Sunny", icon: "someIcon", code: 1009)
    let current = CurrentWeather(temp_c: 20.0, wind_kph: 25.0, humidity: 80, feelslike_c: 20.0, condition: condition)
    let day = Day(maxtemp_c: 30.0, mintemp_c: 10.0, maxwind_kph: 23.0, avghumidity: 80, condition: condition)
    let forecastDay = Forecastday(day: day, date: "2024-09-18")
    let forecast = Forecast(forecastday: [forecastDay])
    return WeatherResponse(current: current, forecast: forecast)
}

