//
//  UIApplication+Extensions.swift
//  WeatherForecast
//
//  Created by Ashish Gour on 18/09/24.
//

import Foundation
import UIKit


extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
