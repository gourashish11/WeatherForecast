//
//  WeatherForecastApp.swift
//  WeatherForecast
//
//  Created by Ashish Gour on 18/09/24.
//

import SwiftUI

@main
struct WeatherForecastApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherMainView(viewModel: WeatherForcastViewModel())
        }
    }
}
