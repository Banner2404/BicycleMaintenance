//
//  ServiceType+CoreDataProperties.swift
//  BicycleMaintenance
//
//  Created by Евгений Соболь on 5/24/20.
//  Copyright © 2020 Esobol. All rights reserved.
//
//

import Foundation
import CoreData


extension ServiceType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ServiceType> {
        return NSFetchRequest<ServiceType>(entityName: "ServiceType")
    }

    @NSManaged public var name: String?
    @NSManaged public var distance: Int64

}
