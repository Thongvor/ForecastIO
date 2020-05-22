//
//  CurrentWeather.swift
//  ForecastIO
//
//  Created by Dmytro Holovko on 22.05.2020.
//  Copyright © 2020 DHU. All rights reserved.
//

import Foundation

struct CurrentWeatherResponse: Codable {
    let weather: [Weather]
    let main: Main
    let name: String
    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    struct Main: Codable {
        let temp: Float
        let feels_like: Float
        let temp_min: Float
        let temp_max: Float
        let pressure: Int
        let humidity: Int
    }
}
