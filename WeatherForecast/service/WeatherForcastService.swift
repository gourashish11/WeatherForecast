//
//  WeatherForcastService.swift
//  WeatherForecast
//
//  Created by Ashish Gour on 18/09/24.
//

import Foundation
import Combine

protocol WeatherForcastService {
    func fetchWeather(for city: String) -> AnyPublisher<WeatherResponse, Error>
}


class WeatherForcastAPIService: WeatherForcastService  {
    
    private let urlBuilder: WeatherUrlBuilder
    private let dataFetcher: DataFetcher
    
    init(dataFetcher: DataFetcher = URLSessionDataFetcher(),
         urlBuilder: WeatherUrlBuilder = WeatherUrlHandler()) {
        self.dataFetcher = dataFetcher
        self.urlBuilder = urlBuilder
    }
    
    func fetchWeather(for city: String) -> AnyPublisher<WeatherResponse, Error>{
        
        let urlString = urlBuilder.build(city: city) ?? ""
        
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        return dataFetcher.fetchData(from: url)
            .map(\.data)
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
