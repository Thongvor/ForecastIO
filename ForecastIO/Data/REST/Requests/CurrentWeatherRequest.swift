//
//  CurrentWeatherRequest.swift
//  ForecastIO
//
//  Created by Dmytro Holovko on 21.05.2020.
//  Copyright © 2020 DHU. All rights reserved.
//

import Foundation
import Alamofire

class CurrentWeatherRequest: FIOGetRequest {
    var url: String!
    let cityName: String
    init (cityName: String) {
        self.cityName = cityName
        self.url = "\(URLManager.base+URLManager.currentWaether)?q=\(self.cityName)&appid=\(URLManager.key)&units=metric"
    }
}


