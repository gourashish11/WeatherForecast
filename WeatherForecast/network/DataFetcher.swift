//
//  DataFetcher.swift
//  WeatherForecast
//
//  Created by Ashish Gour on 18/09/24.
//

import Foundation
import Combine

protocol DataFetcher {
    func fetchData(from url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
}

class URLSessionDataFetcher: DataFetcher {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchData(from url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        session.dataTaskPublisher(for: url)
            .mapError { $0 as URLError }
            .eraseToAnyPublisher()
    }
}
