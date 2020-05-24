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

    private init() {}

    func setupInitialData() {
        setupInitialService(name: "Lube chain", distance: 200)
        setupInitialService(name: "Replace chain", distance: 3000)
        setupInitialService(name: "Charge computer", distance: 100)
        saveContext()
    }

    func loadEntities() -> [ServiceType] {
        let fetchRequest: NSFetchRequest<ServiceType> = ServiceType.fetchRequest()
        do {
            return try managedContext.fetch(fetchRequest)
        } catch {
            fatalError("Unable to fetch entities")
        }

    }
    
    func saveContext () {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    private func setupInitialService(name: String, distance: Int) {
        let service = ServiceType(context: persistentContainer.viewContext)
        service.name = name
        service.distance = Int64(distance)
    }
}
