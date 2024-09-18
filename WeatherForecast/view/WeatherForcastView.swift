//
//  WeatherForcastView.swift
//  WeatherForecast
//
//  Created by Ashish Gour on 18/09/24.
//

import SwiftUI

struct WeatherForcastView: View {
    
    @ObservedObject var viewModel: WeatherForcastViewModel
    
    var body: some View {
        Text("Weather in \(viewModel.city)")
            .font(.title)
            .foregroundColor(.blue)
            .padding()
        
        let dataSource = viewModel.currentWeather?.forecast?.forecastday ?? []
        
        List(dataSource) { forcastDay in
            
            let minTemp = forcastDay.day?.mintemp_c?.toTwoDecimal() ?? ""
            let maxTemp = forcastDay.day?.maxtemp_c?.toTwoDecimal() ?? ""
            
            let minWind = forcastDay.day?.minwind_kph?.toTwoDecimal() ?? ""
            let maxWind = forcastDay.day?.maxwind_kph?.toTwoDecimal() ?? ""
            
            let humidity = forcastDay.day?.avghumidity
            let date =  viewModel.formatDateString(forcastDay.date ?? "") ?? ""
            
            VStack {
                
                Spacer(minLength: 20)
                
                Text("\(date)")
                    .font(.title2)
                    .foregroundColor(.blue)
                    .multilineTextAlignment(.center)
                
                HStack {
                    Text("Minimum temperature:")
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Text("\(minTemp)°C")
                        .font(.callout)
                        .multilineTextAlignment(.trailing)
                }.padding()
                
                HStack {
                    Text("Maximum temperature:")
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Text("\(maxTemp)°C")
                        .font(.callout)
                        .multilineTextAlignment(.trailing)
                }.padding()
                
                HStack {
                    Text("Minimum wind:")
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Text("\(minWind)KMPH")
                        .font(.callout)
                        .multilineTextAlignment(.trailing)
                }.padding()
                
                HStack {
                    Text("Maximum wind:")
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    
                    Text("\(maxWind)KMPH")
                        .font(.callout)
                        .multilineTextAlignment(.trailing)
                }.padding()
                
                HStack {
                    Text("Average humidity:")
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Text("\(humidity ?? 0)")
                        .font(.callout)
                        .multilineTextAlignment(.trailing)
                }.padding()
                
                Spacer(minLength: 20)
            }
           
        }
        
        .navigationBarTitle("Forecast", displayMode: .inline)
    }
}

