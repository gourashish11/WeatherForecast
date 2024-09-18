//
//  ContentView.swift
//  WeatherForecast
//
//  Created by Ashish Gour on 18/09/24.
//

import SwiftUI


struct WeatherMainView: View {
    
    @ObservedObject var viewModel: WeatherForcastViewModel

       var body: some View {
           
           NavigationView {
               VStack {
                   
                  WeatherForm(viewModel: viewModel)
                   .padding()

                   if let _ = viewModel.currentWeather, !viewModel.city.isEmpty {
                      WeatherResultsView(viewModel: viewModel)
                       
                   } else if let errorMessage = viewModel.errorMessage {
                       Text(errorMessage)
                           .foregroundColor(.red)
                           .padding()
                   }
                   
                  // Spacer(minLength: 50)
               }
               .padding()
               .navigationTitle("Weather Forecast")
               .navigationBarTitleDisplayMode(.inline) 
           }
       }
}


