//
//  FIOResponseParser.swift
//  ForecastIO
//
//  Created by Dmytro Holovko on 22.05.2020.
//  Copyright © 2020 DHU. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class FIOParser<T:Codable> {
    private let response: AFDataResponse<Any>
    
    init(response: AFDataResponse<Any>) {
        self.response = response
    }
    
    func parse() -> Single<T> {
        return Single<T>.deferred{
            if let data = self.response.data,
                let response = try? JSONDecoder().decode(T.self, from: data) {
                return Single.just(response)
            } else if let error = self.response.error {
                return Single.error(error)
            } else {
                return Single.error(NSError(domain: "There is no such city", code: -1, userInfo: nil))
            }
        }
    }
}
