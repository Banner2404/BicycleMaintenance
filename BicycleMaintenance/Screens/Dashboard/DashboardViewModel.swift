//
//  DashboardViewModel.swift
//  BicycleMaintenance
//
//  Created by Евгений Соболь on 5/24/20.
//  Copyright © 2020 Esobol. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CoreData

class DashboardViewModel {

    var services: Driver<[ServiceTypeViewModel]> {
        servicesRelay.asDriver()
    }

    var numberOfServices: Int {
        servicesRelay.value.count
    }

    private let servicesRelay = BehaviorRelay<[ServiceTypeViewModel]>(value: [])
    private let disposeBag = DisposeBag()

    init() {
        Observable
            .combineLatest(CoreDataManager.shared.services, WorkoutDataManager.shared.distance)
            .map { services, distance in
                return services
                    .map { service in
                        ServiceTypeViewModel(service: service, totalDistance: distance)
                    }
                    .sorted { $0.health < $1.health }
            }
            .bind(to: servicesRelay)
            .disposed(by: disposeBag)
    }

    func viewModelForService(at index: Int) -> ServiceTypeViewModel {
        return servicesRelay.value[index]
    }
}
