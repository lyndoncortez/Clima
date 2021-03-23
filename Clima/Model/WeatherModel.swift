//
//  WeatherModel.swift
//  Clima
//
//  Created by  LYNDON on 3/17/21.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let country: String
    let temperature: Double
    let main: String
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 800:
            return "sun.max"
        default:
            return "cloud"
        }
    }
}
