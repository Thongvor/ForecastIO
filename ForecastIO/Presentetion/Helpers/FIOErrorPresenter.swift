//
//  FIOErrorPresenter.swift
//  ForecastIO
//
//  Created by Dmytro Holovko on 22.05.2020.
//  Copyright © 2020 DHU. All rights reserved.
//

import Foundation
import UIKit

class FIOErrorPresenter {
    func present(error: Error, on viewController: UIViewController) {
        let err = error as NSError
        let alertController = UIAlertController(title: "Error",
                                                message: err.domain,
                                                preferredStyle: .alert)
        alertController.addAction(.init(title: "OK", style: .default))
        viewController.present(alertController, animated: true)
    }
}
