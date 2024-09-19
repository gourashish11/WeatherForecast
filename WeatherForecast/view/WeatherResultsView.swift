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
            let description = viewModel.currentWeather?.current?.condition?.text ?? ""
            let feelslike = viewModel.currentWeather?.current?.feelslike_c ?? 0
            
            
            Text("\(viewModel.city)")
                .font(.title3)
                .padding(10)
            
            ZStack {
                Circle()
                    .stroke(Color.blue, lineWidth: 1)
                    .background(Circle().fill(Color.clear))
                    .frame(width: 120, height: 120)
                
                Text("\(temp.toTwoDecimal())C")
                    .font(.title)
                    .foregroundColor(.blue)
                    .multilineTextAlignment(.center)
                    .padding(5)
            }
            
            
            
            Text("\(description)")
                .font(.title3)
                .foregroundColor(.green)
                .multilineTextAlignment(.center)
                .padding(5)
            
            Text("Feels like \(feelslike.toTwoDecimal())")
                .font(.title2)
                .multilineTextAlignment(.center)
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
                .stroke(Color.blue, lineWidth: 0.5)
        )
        .padding()
        
    }
}

