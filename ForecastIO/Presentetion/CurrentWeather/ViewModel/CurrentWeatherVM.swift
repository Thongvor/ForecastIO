//
//  MainScreenVM.swift
//  ForecastIO
//
//  Created by Dmytro Holovko on 21.05.2020.
//  Copyright © 2020 DHU. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class CurrentWeatherVM {
    private let currentWeatherUseCase: CurrentWeatherUseCase
    
    init(currentWeatherUseCase: CurrentWeatherUseCase) {
        self.currentWeatherUseCase = currentWeatherUseCase
    }
    
    func trasform(input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let weather = input.seachButtonPressed
            .withLatestFrom(input.cityText)
            .flatMapLatest { [weak self] (city) in
                (self?.currentWeatherUseCase
                    .currentWeather(in: city)
                    .trackError(errorTracker)
                    .asDriver(onErrorRecover: { _ in
                        return Driver.empty()
                    }) ?? Driver.empty())
        }
    
        return Output(
            weather: weather,
            errors: errorTracker.asDriver()
        )
    }
}

extension CurrentWeatherVM {
    struct Input {
        let cityText: Driver<String>
        let seachButtonPressed: Driver<Void>
    }
    struct Output {
        let weather: Driver<CurrentWeatherModel>
        let errors: Driver<Error>
    }
}
