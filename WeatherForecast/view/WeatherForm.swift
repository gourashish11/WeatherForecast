//
//  WeatherForm.swift
//  WeatherForecast
//
//  Created by Ashish Gour on 18/09/24.
//

import SwiftUI

struct WeatherForm: View {
    @ObservedObject var viewModel: WeatherForcastViewModel
    
    var body: some View {
        
        Form {
            Section(header: Text("Enter city")) {
                HStack {
                    TextField("Enter city name", text: $viewModel.city)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .onChange(of: viewModel.city, { oldValue, newValue in
                            if newValue.isEmpty {
                                viewModel.currentWeather = nil
                                viewModel.errorMessage = nil
                            }
                        })
                    Button(action: {
                        viewModel.fetchWeatherDetails()
                    }) {
                        Text("Go")
                            .font(.headline)
                    }
                    .disabled(viewModel.shouldDisable())
                    
                }
               
            }
            
        }
        .frame(height: 100)
        .navigationTitle("Weather Forecast")
    }
}


