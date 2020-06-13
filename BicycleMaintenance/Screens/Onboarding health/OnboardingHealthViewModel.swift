//
//  OnboardingHealthViewModel.swift
//  BicycleMaintenance
//
//  Created by Евгений Соболь on 6/13/20.
//  Copyright © 2020 Esobol. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class OnboardingHealthViewModel {

    var isConnecting: Driver<Bool> {
        connectingRelay.asDriver()
    }

    weak var viewController: UIViewController?
    private let connectingRelay = BehaviorRelay<Bool>(value: false)

    func connect() {
        connectingRelay.accept(true)
        WorkoutDataManager.shared.authorizeHealthKit { [weak self] _ in
            self?.connectingRelay.accept(false)
            self?.viewController?.dismiss(animated: true, completion: nil)
        }
    }
}
