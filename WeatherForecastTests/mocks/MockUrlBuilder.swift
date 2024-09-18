//
//  MockUrlBuilder.swift
//  CurrencyConverterTests
//
//  Created by Ashish Gour on 17/09/24.
//

import Foundation
@testable import WeatherForecast

class MockUrlBuilder: WeatherUrlBuilder {
    
    func build(city: String) -> String {
        guard !shouldSetError else {
            return ""
        }
        
        return "https://domain.com/path"
    }
    
    
    private let shouldSetError: Bool
    
    init(shouldSetError: Bool = false) {
        self.shouldSetError = shouldSetError
    }
    
}
