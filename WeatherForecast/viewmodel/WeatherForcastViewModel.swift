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
    
    init(weatherForcastService: WeatherForcastService = WeatherForcastAPIService()) {
        self.weatherForcastService = weatherForcastService
    }
    
    func fetchWeatherDetails() {
        hideKeyboard()
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
                self?.currentWeather = weatherResponse
                self?.errorMessage = nil
            })
            .store(in: &cancellables)
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
    
}
