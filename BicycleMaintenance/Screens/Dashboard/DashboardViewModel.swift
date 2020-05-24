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
    private let distanceRelay = BehaviorRelay<Int>(value: 0)
    private let disposeBag = DisposeBag()

    func loadData() {
        Observable
            .zip(loadServices().asObservable(), loadWorkouts().asObservable())
            .subscribe(onNext: { [weak self] services, distance in
                self?.servicesRelay.accept(services)
                self?.distanceRelay.accept(distance)
            })
            .disposed(by: disposeBag)
    }

    func viewModelForService(at index: Int) -> ServiceTypeViewModel {
        return ServiceTypeViewModel(service: servicesRelay.value[index], totalDistance: distanceRelay.value)
    }

    private func loadServices() -> Single<[ServiceType]> {
        return Single.just(CoreDataManager.shared.loadEntities())
    }

    private func loadWorkouts() -> Single<Int> {
        return Single.create { observer in
            WorkoutDataManager.shared.loadTotalDistance { distance in
                observer(.success(distance ?? 0))
            }
            return Disposables.create()
        }
    }
}
