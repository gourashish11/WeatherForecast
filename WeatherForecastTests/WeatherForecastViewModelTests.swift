//
//  WeatherForecastTests.swift
//  WeatherForecastTests
//
//  Created by Ashish Gour on 18/09/24.
//

import XCTest
@testable import WeatherForecast

final class WeatherForecastViewModelTests: XCTestCase {

    func testViewModelSuccessfullyFetchesWeatherDetails() {
        let service = MockWeatherForecastService()
        let storage = MockWeatherStorageManager()
        
        let viewModel = WeatherForcastViewModel(weatherForcastService: service, weatherStorageManager: storage)
        
        let expectation = XCTestExpectation(description: "Fetch weather details")
        
        viewModel.fetchWeatherDetails()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(service.fetchWeatherDetailsCalled)
        XCTAssertNotNil(viewModel.currentWeather)
    }
    
    func testViewModelSuccessfullySavesWeatherDetailsForGivenCity() {
        let service = MockWeatherForecastService()
        let storage = MockWeatherStorageManager()
        let viewModel = WeatherForcastViewModel(weatherForcastService: service, weatherStorageManager: storage)
        
        let expectation = XCTestExpectation(description: "Fetch weather details")
        
        viewModel.fetchWeatherDetails()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(storage.saveWeatherCalled)
        XCTAssertNotNil(viewModel.currentWeather)
    }
    
    func testViewModelLoadsWeatherDataFromStorageIf4hoursNotPassed() {
        let service = MockWeatherForecastService()
        let storage = MockWeatherStorageManager()
        let viewModel = WeatherForcastViewModel(weatherForcastService: service, weatherStorageManager: storage)
        viewModel.city = "someCity"
        
        let expectation = XCTestExpectation(description: "Fetch weather details")
        
        viewModel.fetchWeatherDetails()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(storage.loadWeatherCalled)
        XCTAssertNotNil(viewModel.currentWeather)
    }
    
    func testViewModelFetvhWeatherDetailsIf4hoursHavePassed() {
        let service = MockWeatherForecastService()
        let fourHourEarlier = getFourHoursEarlier()
        let storage = MockWeatherStorageManager(lastFetchTime: fourHourEarlier!)
        let viewModel = WeatherForcastViewModel(weatherForcastService: service, weatherStorageManager: storage)
        
        let expectation = XCTestExpectation(description: "Fetch weather details")
        
        viewModel.fetchWeatherDetails()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(service.fetchWeatherDetailsCalled)
        XCTAssertNotNil(viewModel.currentWeather)
    }
    
    func testViewModelShowsErrorInCaseOfFailedWeatherDetails() {
        
        let service = MockWeatherForecastService(shouldSetError: true)
        let storage = MockWeatherStorageManager()
        let viewModel = WeatherForcastViewModel(weatherForcastService: service, weatherStorageManager: storage)
        
        let expectation = XCTestExpectation(description: "Fetch weather details")
        
        viewModel.fetchWeatherDetails()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(service.fetchWeatherDetailsCalled)
        XCTAssertNil(viewModel.currentWeather)
        XCTAssertNotNil(viewModel.errorMessage)
    }
    
    func testViewModelFormatesDateStringInCorrectManner() {
        
        let service = MockWeatherForecastService()
        let viewModel = WeatherForcastViewModel(weatherForcastService: service)
        let dateString = viewModel.formatDateString("2024-09-18")
        XCTAssertEqual(dateString, "18 Sep 2024")
    }
    
    func testViewModelShouldDisableActionButtonInCaseOfEmptyCity() {
        
        let service = MockWeatherForecastService()
        let viewModel = WeatherForcastViewModel(weatherForcastService: service)
        viewModel.city = ""
        XCTAssertTrue(viewModel.shouldDisable())
    }
}
