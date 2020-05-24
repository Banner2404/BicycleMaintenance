//
//  CoreDataManager.swift
//  BicycleMaintenance
//
//  Created by Евгений Соболь on 5/24/20.
//  Copyright © 2020 Esobol. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {

    static let shared = CoreDataManager()

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BicycleMaintenance")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private var managedContext: NSManagedObjectContext { persistentContainer.viewContext }
    private let initialDataLoadedKey = "initialDataLoadedKey"

    private init() {}

    func setupInitialData() {
        guard !UserDefaults.standard.bool(forKey: initialDataLoadedKey) else { return }
        setupInitialService(name: "Lube chain", distance: 200, image: .chain)
        setupInitialService(name: "Replace chain", distance: 3000, image: .chain)
        setupInitialService(name: "Charge computer", distance: 100, image: .computer)
        setupInitialService(name: "Sync computer", distance: 150, image: .computer)
        setupInitialService(name: "Pump tyres", distance: 80, image: .wheel)
        setupInitialService(name: "Clean bike", distance: 300, image: .frame)
        setupInitialService(name: "Replace brakes", distance: 4000, image: .brake)
        setupInitialService(name: "Tighten screws", distance: 500, image: .frame)
        saveContext()
        UserDefaults.standard.set(true, forKey: initialDataLoadedKey)
    }

    func loadEntities() -> [ServiceType] {
        let fetchRequest: NSFetchRequest<ServiceType> = ServiceType.fetchRequest()
        do {
            return try managedContext.fetch(fetchRequest)
        } catch {
            fatalError("Unable to fetch entities")
        }

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

    private func setupInitialService(name: String, distance: Int, image: ServiceType.Image) {
        let service = ServiceType(context: persistentContainer.viewContext)
        service.name = name
        service.distance = Int64(distance)
        service.image = image.rawValue
    }
}
