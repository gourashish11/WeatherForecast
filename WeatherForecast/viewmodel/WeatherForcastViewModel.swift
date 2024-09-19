//
//  WeatherForcastViewModel.swift
//  WeatherForecast
//
//  Created by Ashish Gour on 18/09/24.
//
import Foundation
import Combine
import UIKit

class WeatherForcastViewModel: ObservableObject {
    
    @Published var city: String = ""
    @Published var currentWeather: WeatherResponse?
    @Published var errorMessage: String?
    private let weatherForcastService: WeatherForcastService
    private var cancellables = Set<AnyCancellable>()
    private let storageManager: WeatherStorageManager
    
    init(weatherForcastService: WeatherForcastService = WeatherForcastAPIService(),
         weatherStorageManager: WeatherStorageManager = WeatherStorage()) {
        self.weatherForcastService = weatherForcastService
        self.storageManager = weatherStorageManager
    }
    
    func fetchWeatherDetails() {
        hideKeyboard()
        
        if let weather = loadWeather(city: city), let lastFetchTime = weather.lastFetchTime, !isWeatherDataExpired(from: lastFetchTime) {
            currentWeather = weather
            errorMessage = nil
        } else {
            fetchWeather()
        }
    }
    
    private func fetchWeather() {
        weatherForcastService.fetchWeather(for: city)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.handleCompletion(completion)
            }, receiveValue: { [weak self] weatherResponse in
                guard let _ = weatherResponse.current else {
                    self?.currentWeather = nil
                    self?.errorMessage = "No results found. Please make sure city is correct"
                    return
                }
                self?.handleSuccess(weatherResponse: weatherResponse)
            })
            .store(in: &cancellables)
    }
    
    private func handleSuccess(weatherResponse: WeatherResponse) {
        var weather = weatherResponse
        weather.lastFetchTime = Date()
        storeWeatherData(weather: weather)
        currentWeather = weather
        errorMessage = nil
    }
    
    private func handleCompletion(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .failure(let error):
            self.errorMessage = error.localizedDescription
            self.currentWeather = nil
        case .finished:
            break
        }
    }
    
    func formatDateString(_ dateString: String) -> String? {
        
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = inputDateFormatter.date(from: dateString) else {
            return nil
        }
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "dd MMM yyyy"
        
        return outputDateFormatter.string(from: date)
    }
    
    func shouldDisable() -> Bool {
        return city.isEmpty
    }
    
    private func hideKeyboard() {
        UIApplication.shared.endEditing()
    }
    
    private func storeWeatherData(weather: WeatherResponse) {
        storageManager.saveWeather(weather, city: city)
    }
    
    private func loadWeather(city: String) -> WeatherResponse? {
        return storageManager.loadWeather(city: city)
    }
    
    private func isWeatherDataExpired(from lastFetchDate: Date) -> Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: lastFetchDate, to: Date())
        
        guard let hours = components.hour else {
            return false
        }
        
        return hours >= WeatherForecast.expiredHours
    }
    
}
