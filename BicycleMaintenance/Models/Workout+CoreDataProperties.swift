//
//  Workout+CoreDataProperties.swift
//  
//
//  Created by Евгений Соболь on 6/8/20.
//
//

import Foundation
import CoreData


extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }

    @NSManaged public var distance: Int64
    @NSManaged public var uuid: UUID
    @NSManaged public var date: Date
    @NSManaged public var isHidden: Bool

}
