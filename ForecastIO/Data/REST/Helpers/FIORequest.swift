//
//  FIORequest.swift
//  ForecastIO
//
//  Created by Dmytro Holovko on 21.05.2020.
//  Copyright © 2020 DHU. All rights reserved.
//

import Foundation
import Alamofire

protocol FIOGetRequest {
    var url: String! { get }
    func parameters() -> Parameters?
    func headers() -> HTTPHeaders?
    func request() -> DataRequest
}

extension FIOGetRequest {
    func parameters() -> Parameters? {
        return nil
    }
    
    func headers() -> HTTPHeaders? {
        return nil
    }
    
    func request() -> DataRequest {
        return AF.request(
            self.url,
            method: .get,
            parameters: self.parameters(),
            encoding: JSONEncoding.default,
            headers: self.headers()
        )
    }
}
