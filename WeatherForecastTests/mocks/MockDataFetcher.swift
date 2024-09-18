//
//  MockDataFetcher.swift
//  CurrencyConverterTests
//
//  Created by Ashish Gour on 17/09/24.
//

import Foundation
@testable import WeatherForecast
import Combine

class MockDataFetcher: DataFetcher {
    var data: Data?
    var error: URLError?
    
    init(data: Data? = nil, error: URLError? = nil) {
        self.data = data
        self.error = error
    }
    
    func fetchData(from url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        if let error = error {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        return Just((data: data ?? Data(), response: response))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher()
    }
}
