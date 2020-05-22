//
//  CurrentWeatherUseCase.swift
//  ForecastIO
//
//  Created by Dmytro Holovko on 21.05.2020.
//  Copyright © 2020 DHU. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol CurrentWeatherUseCase {
    func currentWeather(in city: String) -> Single<CurrentWeatherModel>
}
