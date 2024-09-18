//
//  WeatherUrlBuilder.swift
//  WeatherForecast
//
//  Created by Ashish Gour on 18/09/24.
//

import Foundation

protocol WeatherUrlBuilder {
    func build(city: String) -> String?
}

struct WeatherUrlHandler: WeatherUrlBuilder {
    
//    func build(city: String) -> String {
//        return "\(WeatherForecast.baseUrl)?q=\(city)&key=\(WeatherForecast.apiKey)&days=5"
//    }
    
    func build(city: String) -> String? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = WeatherForecast.baseUrl
        components.path = WeatherForecast.path
        
        components.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "key", value: WeatherForecast.apiKey),
            URLQueryItem(name: "days", value: WeatherForecast.days)
        ]
        
        return components.url?.absoluteString
    }
}
