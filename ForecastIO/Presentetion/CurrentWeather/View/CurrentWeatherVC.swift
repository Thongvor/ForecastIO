//
//  MainScreenVC.swift
//  ForecastIO
//
//  Created by Dmytro Holovko on 21.05.2020.
//  Copyright © 2020 DHU. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class CurrentWeatherVC: UIViewController {
    static let storyboardId = "CurrentWeatherVC"
    typealias ViewModel = CurrentWeatherVM
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherDesrLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var feelsLikeTextLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var contentView: UIView! {
        didSet {
            self.contentView.isHidden = true
        }
    }
    
    // MARK: - PROPERTIES
    
    private let disposeBag = DisposeBag()
    private let errorPresenter = FIOErrorPresenter()
    var viewModel: ViewModel!
    var errorBinding: Binder<Error> {
        return Binder(self, binding: { [weak self] (viewController, error) in
            self?.errorPresenter.present(error: error, on: viewController)
        })
    }
    
    // MARK: - LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind(with: self.viewModel)
        self.addTapGesture()
    }
    
    // MARK: - REACTIVE BINDINGS
    
    private func bind(with viewModel: ViewModel) {
        let input = ViewModel.Input(
            cityText: self.searchTextField.rx.text.orEmpty.asDriver(),
            seachButtonPressed: self.searchButton.rx.tap.asDriver()
        )
        let output = viewModel.trasform(input: input)
        [
            output.weather.drive(onNext: self.configureView(with:)),
            output.errors.drive(self.errorBinding)
        ].forEach { $0.disposed(by: self.disposeBag) }
    }
}

// MARK: - VIEW CONFIGURATIONS -

extension CurrentWeatherVC {
    private func configureView(with model: CurrentWeatherModel) {
        self.cityLabel.text = model.city
        self.weatherDesrLabel.text = model.weatherDescription
        self.tempLabel.text = model.temperature
        self.feelsLikeTextLabel.text = model.feelsTemperature
        self.minTempLabel.text = model.minTemperature
        self.maxTempLabel.text = model.maxTemperature
        self.pressureLabel.text = model.preassure
        self.humidityLabel.text = model.humidity
        UIView.animate(withDuration: 0.3) {
            self.contentView.isHidden = false
        }
    }
    
    private func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
    }
    
    @objc private func dismissKeyboard() {
        self.view.endEditing(true)
    }
}


