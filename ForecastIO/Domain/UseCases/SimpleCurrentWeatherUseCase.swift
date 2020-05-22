//
//  SimpleCurrentWeatherUseCase.swift
//  ForecastIO
//
//  Created by Dmytro Holovko on 22.05.2020.
//  Copyright © 2020 DHU. All rights reserved.
//

import Foundation
import RxSwift

class SimpleCurrentWeatherUseCase: CurrentWeatherUseCase {
    private let service: CurrentWeatherService
    
    init(service: CurrentWeatherService) {
        self.service = service
    }
    
    func currentWeather(in city: String) -> Single<CurrentWeatherModel> {
        return self.service.currentWeater(in: city).flatMap({ (response) in
            return Single.just(
                CurrentWeatherModel(
                    city: response.name,
                    temperature: String(response.main.temp) + "°C",
                    feelsTemperature: String(response.main.feels_like) + "°C",
                    minTemperature: String(response.main.temp_min) + "°C",
                    maxTemperature: String(response.main.temp_max) + "°C",
                    weatherDescription: response.weather[0].main,
                    preassure: String(response.main.pressure),
                    humidity: String(response.main.humidity) + "%"
                )
            )
        })
    }
}
