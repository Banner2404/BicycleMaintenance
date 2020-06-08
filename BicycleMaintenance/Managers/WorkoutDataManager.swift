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

    private let disposeBag = DisposeBag()
    private let anchorKey = "QueryAnchorKey"

    private init() {
        NotificationCenter.default.rx.notification(UIApplication.didBecomeActiveNotification)
            .bind { [weak self] _ in
                self?.loadTotalDistance()
            }
            .disposed(by: disposeBag)
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
        print("Load distance")
        let predicate = HKQuery.predicateForWorkouts(with: .cycling)
        let query = HKAnchoredObjectQuery(
            type: .workoutType(),
            predicate: predicate,
            anchor: restoreAnchor(),
            limit: HKObjectQueryNoLimit
        ) { [weak self] query, samples, deletedObjects, anchor, error in
            if let error = error {
                print(error)
            }
            guard let workouts = samples as? [HKWorkout] else {
                print("Unable to get workouts")
                return
            }
            print("new samples \(workouts.count)")
            // TODO: handle deleted workouts
            CoreDataManager.shared.update(workouts)
            if let anchor = anchor {
                self?.save(anchor: anchor)
            }
        }
        HKHealthStore().execute(query)
    }

    private func save(anchor: HKQueryAnchor) {
        guard let data = try? NSKeyedArchiver.archivedData(withRootObject: anchor, requiringSecureCoding: false) else {
            return
        }
        UserDefaults.standard.set(data, forKey: anchorKey)
    }

    private func restoreAnchor() -> HKQueryAnchor? {
        guard let data = UserDefaults.standard.data(forKey: anchorKey) else { return nil }
        return try? NSKeyedUnarchiver.unarchivedObject(ofClass: HKQueryAnchor.self, from: data)
    }
}
