//
//  CurrentWeatherService.swift
//  ForecastIO
//
//  Created by Dmytro Holovko on 21.05.2020.
//  Copyright © 2020 DHU. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

protocol CurrentWeatherService {
    func currentWeater(in city: String) -> Single<CurrentWeatherResponse>
}
