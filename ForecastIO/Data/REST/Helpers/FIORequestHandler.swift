//
//  FIORequestHandler.swift
//  ForecastIO
//
//  Created by Dmytro Holovko on 22.05.2020.
//  Copyright © 2020 DHU. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class FIORequestHandler {
    private let request: DataRequest
    
    init(request: DataRequest) {
        self.request = request
    }
    
    func response() -> Single<AFDataResponse<Any>> {
        return Single<AFDataResponse<Any>>.create { single in
            self.request.responseJSON { response in
                single(.success(response))
            }
            return Disposables.create {
                self.request.cancel()
            }
        }
    }
}
