//
//  WeatherForecastServiceTests.swift
//  WeatherForecastTests
//
//  Created by Ashish Gour on 18/09/24.
//

import XCTest
import Combine
@testable import WeatherForecast

final class WeatherForecastServiceTests: XCTestCase {
    
    private var cancellables = Set<AnyCancellable>()
    
    func testWeatherForecastServiceShouldSucessInCaseOfValidUrl() {
        
        let mockCurrencyRates = getWeatherDetails()
        
        let mockData = try? JSONEncoder().encode(mockCurrencyRates)
        
        let mockFetcher = MockDataFetcher(data: mockData)
        
        let urlBuilder = MockUrlBuilder()
        
        let service = WeatherForcastAPIService(dataFetcher: mockFetcher, urlBuilder: urlBuilder)
        
        let expectation = self.expectation(description: "Fetch weather")
        
        service.fetchWeather(for: "someCity")
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { weather in
                XCTAssertEqual(weather.current?.humidity, 80)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchCurrencyRatesServiceShouldReturnInvalidUrlErrorInCaseOfInvalidUrl() {
        
        let mockFetcher = MockDataFetcher()
        
        let urlBuilder = MockUrlBuilder(shouldSetError: true)
        
        let service = WeatherForcastAPIService(dataFetcher: mockFetcher, urlBuilder: urlBuilder)
        
        let expectation = self.expectation(description: "Fetch weather")
        
        service.fetchWeather(for: "someCity")
            .sink(receiveCompletion: { completion in
                if case .failure(let error as URLError) = completion {
                    XCTAssertEqual(error.code, .badURL)
                    expectation.fulfill()
                }
                
            }, receiveValue: { _ in
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
}

