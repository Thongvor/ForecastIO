//
//  SimpleCurrentWeatherService.swift
//  ForecastIO
//
//  Created by Dmytro Holovko on 22.05.2020.
//  Copyright © 2020 DHU. All rights reserved.
//

import Foundation
import RxSwift

class SimpleCurrentWeatherService: CurrentWeatherService {
    func currentWeater(in city: String) -> Single<CurrentWeatherResponse> {
        let request = CurrentWeatherRequest(cityName: city).request()
        let response = FIORequestHandler(request: request).response().flatMap { (response) in
            return FIOParser<CurrentWeatherResponse>(response: response).parse()
        }
        return response
    }
}
