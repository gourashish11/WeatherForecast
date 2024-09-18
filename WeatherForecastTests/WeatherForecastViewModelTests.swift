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
        let viewModel = WeatherForcastViewModel(weatherForcastService: service)
        
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
        let viewModel = WeatherForcastViewModel(weatherForcastService: service)
        
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
