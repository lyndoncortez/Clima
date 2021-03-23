//
//  WeatherData.swift
//  Clima
//
//  Created by  LYNDON on 3/16/21.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let sys: Sys
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
    let main: String
}

struct Sys: Codable {
    let country: String
}

