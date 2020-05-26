//
//  WorkoutDataManager.swift
//  BicycleMaintenance
//
//  Created by Евгений Соболь on 5/23/20.
//  Copyright © 2020 Esobol. All rights reserved.
//

import Foundation
import HealthKit
import RxSwift
import RxCocoa

class WorkoutDataManager {

    static let shared = WorkoutDataManager()
    var distance: Observable<Int> {
        return distanceSubject.asObservable()
    }

    private let distanceSubject = ReplaySubject<Int>.create(bufferSize: 1)

    private init() {
        loadTotalDistance()
    }

    func authorizeHealthKit(completion: @escaping (Bool) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            // TODO: change UI
            print("Health data is not available")
            completion(false)
            return
        }

        let workoutType = HKObjectType.workoutType()
        let dataTypes = Set([workoutType])
        HKHealthStore().requestAuthorization(toShare: nil, read: dataTypes) { (success, error) in
            if let error = error {
                print(error)
            }
            completion(success)
        }
    }

    func loadTotalDistance() {
        authorizeHealthKit { [weak self] authorized in
            guard authorized else {
                return
            }
            self?.loadDistanceData()
        }
    }

    private func loadDistanceData() {
        let predicate = HKQuery.predicateForWorkouts(with: .cycling)
        let query = HKSampleQuery(sampleType: .workoutType(), predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { [weak self] query, samples, error in
            if let error = error {
                print(error)
            }
            guard let workouts = samples as? [HKWorkout] else {
                print("Unable to get workouts")
                return
            }
            let totalDistance = workouts.reduce(0) { sum, workout in
                return sum + (workout.totalDistance?.doubleValue(for: .meterUnit(with: .kilo)) ?? 0)
            }
            DispatchQueue.main.async {
                self?.distanceSubject.on(.next(Int(totalDistance)))
            }
        }
        HKHealthStore().execute(query)
    }
}
