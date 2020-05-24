//
//  WorkoutDataManager.swift
//  BicycleMaintenance
//
//  Created by Евгений Соболь on 5/23/20.
//  Copyright © 2020 Esobol. All rights reserved.
//

import Foundation
import HealthKit

class WorkoutDataManager {

    static let shared = WorkoutDataManager()

    private init() {}

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

    func loadTotalDistance(completion: @escaping (Int?) -> Void) {
        authorizeHealthKit { [weak self] authorized in
            guard authorized else {
                completion(nil)
                return
            }
            self?.loadDistanceData(completion: completion)
        }
    }

    private func loadDistanceData(completion: @escaping (Int?) -> Void) {
        let predicate = HKQuery.predicateForWorkouts(with: .cycling)
        let query = HKSampleQuery(sampleType: .workoutType(), predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { query, samples, error in
            if let error = error {
                print(error)
                completion(nil)
            }
            guard let workouts = samples as? [HKWorkout] else {
                print("Unable to get workouts")
                completion(nil)
                return
            }
            let totalDistance = workouts.reduce(0) { sum, workout in
                return sum + (workout.totalDistance?.doubleValue(for: .meterUnit(with: .kilo)) ?? 0)
            }
            completion(Int(totalDistance))
        }
        HKHealthStore().execute(query)
    }
}
