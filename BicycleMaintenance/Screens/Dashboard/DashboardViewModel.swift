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

class DashboardViewModel {

    var services: Driver<[ServiceType]> {
        servicesRelay.asDriver()
    }

    var numberOfServices: Int {
        servicesRelay.value.count
    }

    private let servicesRelay = BehaviorRelay<[ServiceType]>(value: [])

    func loadData() {
        servicesRelay.accept(CoreDataManager.shared.loadEntities())
    }

    func viewModelForService(at index: Int) -> ServiceTypeViewModel {
        return ServiceTypeViewModel(service: servicesRelay.value[index])
    }
}
