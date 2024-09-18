//
//  Double+Extension.swift
//  WeatherForecast
//
//  Created by Ashish Gour on 18/09/24.
//

import Foundation

extension Double {
    func toTwoDecimal() -> String {
        return String(format: "%.2f", self)
    }
}
