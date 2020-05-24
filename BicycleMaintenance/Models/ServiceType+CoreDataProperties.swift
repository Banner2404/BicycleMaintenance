//
//  ServiceType+CoreDataProperties.swift
//  BicycleMaintenance
//
//  Created by Евгений Соболь on 5/24/20.
//  Copyright © 2020 Esobol. All rights reserved.
//
//

import UIKit
import CoreData


extension ServiceType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ServiceType> {
        return NSFetchRequest<ServiceType>(entityName: "ServiceType")
    }

    @NSManaged public var name: String!
    @NSManaged public var distance: Int64
    @NSManaged public var image: String!
    @NSManaged public var badge: String!
    @NSManaged public var markerX: Double
    @NSManaged public var markerY: Double

    var distanceInt: Int {
        Int(distance)
    }

    var markerPosition: CGPoint {
        return CGPoint(x: markerX, y: markerY)
    }

    enum Image: String {
        case brake
        case chain
        case computer
        case frame
        case wheel
    }

    enum Badge: String {
        case charge
        case clean
        case cloud
        case pump
        case replace
        case screw
    }

}
