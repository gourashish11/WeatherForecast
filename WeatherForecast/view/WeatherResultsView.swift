//
//  WeatherResultsView.swift
//  WeatherForecast
//
//  Created by Ashish Gour on 18/09/24.
//

import SwiftUI

struct WeatherResultsView: View {
    @ObservedObject var viewModel: WeatherForcastViewModel
    
    var body: some View {
        VStack {
            let temp = viewModel.currentWeather?.current?.temp_c ?? 0
            let wind = viewModel.currentWeather?.current?.wind_kph ?? 0
            let humidity = viewModel.currentWeather?.current?.humidity ?? 0
            let description = viewModel.currentWeather?.current?.condition?.text ?? ""
            let feelslike = viewModel.currentWeather?.current?.feelslike_c ?? 0
            
            Text("Weather in \(viewModel.city)")
                .font(.title2)
                .foregroundColor(.blue)
                .padding(5)
            
            HStack {
                Text("tempture:")
                    .font(.title3)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                Text("\(temp.toTwoDecimal())C")
                    .font(.title3)
                    .multilineTextAlignment(.trailing)
            }
            .padding(5)
            
            HStack {
                Text("wind:")
                    .font(.title3)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                Text("\(wind.toTwoDecimal())KMPH")
                    .font(.title3)
                    .multilineTextAlignment(.trailing)
            }
            .padding(5)
            
            HStack {
                Text("humidity:")
                    .font(.title3)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                Text("\(humidity)")
                    .font(.title3)
                    .multilineTextAlignment(.trailing)
            }
            .padding(5)
            
            HStack {
                Text("description:")
                    .font(.title3)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                Text("\(description)")
                    .font(.title3)
                    .multilineTextAlignment(.trailing)
            }
            .padding(5)
            
            HStack {
                Text("feels like:")
                    .font(.title2)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                Text("\(feelslike.toTwoDecimal())")
                    .font(.title2)
                    .multilineTextAlignment(.trailing)
            }
            .padding(5)
            
            NavigationLink(destination: WeatherForcastView(viewModel: viewModel)) {
                Text("Forecast for upcoming 5 days")
                    .font(.headline)
                    .padding()
            }
            
        }
        .frame(height: 280)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.blue, lineWidth: 2)
        )
        .padding()
        
    }
}

