//
//  WorkoutsViewModel.swift
//  BicycleMaintenance
//
//  Created by Евгений Соболь on 6/8/20.
//  Copyright © 2020 Esobol. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class WorkoutsViewModel {

    var workouts: Driver<[WorkoutRecordViewModel]> {
        workoutsRelay.asDriver()
    }

    var numberOfWorkouts: Int {
        workoutsRelay.value.count
    }

    private let workoutsRelay = BehaviorRelay<[WorkoutRecordViewModel]>(value: [])
    private let disposeBag = DisposeBag()

    init() {
        CoreDataManager.shared.workouts
            .map { $0.map { WorkoutRecordViewModel(workout: $0) } }
            .bind(to: workoutsRelay)
            .disposed(by: disposeBag)
    }

    func viewModelForWorkout(at index: Int) -> WorkoutRecordViewModel {
        return workoutsRelay.value[index]
    }
}
