//
//  CoreDataManager.swift
//  BicycleMaintenance
//
//  Created by Евгений Соболь on 5/24/20.
//  Copyright © 2020 Esobol. All rights reserved.
//

import Foundation
import CoreData
import RxSwift
import RxCocoa
import HealthKit

class CoreDataManager {

    static let shared = CoreDataManager()

    var services: Observable<[ServiceType]> {
        return servicesRelay.asObservable()
    }

    var workouts: Observable<[Workout]> {
        return workoutsRelay.asObservable()
    }

    private let servicesRelay = BehaviorRelay<[ServiceType]>(value: [])
    private let workoutsRelay = BehaviorRelay<[Workout]>(value: [])
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BicycleMaintenance")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private let disposeBag = DisposeBag()
    private var managedContext: NSManagedObjectContext { persistentContainer.viewContext }
    private let initialDataLoadedKey = "initialDataLoadedKey"

    private init() {
        NotificationCenter.default.rx.notification(.NSManagedObjectContextObjectsDidChange)
            .subscribe(onNext: { [weak self] _ in
                self?.loadServices()
                self?.loadWorkouts()
            })
            .disposed(by: disposeBag)

        loadServices()
        loadWorkouts()
    }

    func setupInitialData() {
        guard !UserDefaults.standard.bool(forKey: initialDataLoadedKey) else { return }
        setupInitialService(name: "Lube chain", distance: 200, image: .chain, badge: .clean, markerX: 0.7, markerY: 0.6)
        setupInitialService(name: "Replace chain", distance: 3000, image: .chain, badge: .replace, markerX: 0.55, markerY: 0.6)
        setupInitialService(name: "Charge computer", distance: 100, image: .computer, badge: .charge, markerX: 0.35, markerY: 0.2)
        setupInitialService(name: "Sync computer", distance: 400, image: .computer, badge: .cloud, markerX: 0.25, markerY: 0.2)
        setupInitialService(name: "Pump tyres", distance: 120, image: .wheel, badge: .pump, markerX: 0.2, markerY: 0.4)
        setupInitialService(name: "Clean bike", distance: 300, image: .frame, badge: .clean, markerX: 0.5, markerY: 0.3)
        setupInitialService(name: "Replace brakes", distance: 4000, image: .brake, badge: .replace, markerX: 0.3, markerY: 0.6)
        setupInitialService(name: "Tighten screws", distance: 500, image: .frame, badge: .screw, markerX: 0.6, markerY: 0.3)
        saveContext()
        UserDefaults.standard.set(true, forKey: initialDataLoadedKey)
    }

    func loadServices() {
        let fetchRequest: NSFetchRequest<ServiceType> = ServiceType.fetchRequest()
        do {
            servicesRelay.accept(try managedContext.fetch(fetchRequest))
        } catch {
            fatalError("Unable to fetch services")
        }
    }

    func loadWorkouts() {
        let fetchRequest: NSFetchRequest<Workout> = Workout.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        do {
            workoutsRelay.accept(try managedContext.fetch(fetchRequest))
        } catch {
            fatalError("Unable to fetch workouts")
        }
    }

    func update(_ workouts: [HKWorkout]) {
        _ = workouts.map { createWorkout(from: $0) }
        saveContext()
    }
    
    func saveContext() {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    private func setupInitialService(name: String, distance: Int, image: ServiceType.Image,
                                     badge: ServiceType.Badge, markerX: Double, markerY: Double) {
        let service = ServiceType(context: managedContext)
        service.name = name
        service.distance = Int64(distance)
        service.image = image.rawValue
        service.badge = badge.rawValue
        service.markerX = markerX
        service.markerY = markerY
        service.lastRepairDistance = 0
    }

    private func createWorkout(from workout: HKWorkout) -> Workout? {
        guard let distance = workout.totalDistance?.doubleValue(for: .meterUnit(with: .kilo)) else { return nil }
        let workoutObject = Workout(context: managedContext)
        workoutObject.distance = Int64(distance)
        workoutObject.uuid = workout.uuid
        workoutObject.date = workout.startDate
        return workoutObject
    }
}

