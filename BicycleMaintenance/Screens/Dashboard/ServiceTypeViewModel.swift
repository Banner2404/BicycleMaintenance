//
//  ServiceTypeViewModel.swift
//  BicycleMaintenance
//
//  Created by Евгений Соболь on 5/24/20.
//  Copyright © 2020 Esobol. All rights reserved.
//

import UIKit

class ServiceTypeViewModel {

    var name: String {
        return service.name ?? ""
    }

    var distanceLeft: String {
        return "\(distanceToRepair) km left"
    }

    var serviceDistance: String {
        return "\(service.distance) km"
    }

    var health: Double {
        return Double(distanceToRepair) / Double(service.distanceInt)
    }

    var image: UIImage? {
        return UIImage(named: "Services/\(service.image!)")
    }

    var badge: UIImage? {
        return UIImage(named: "Badges/\(service.badge!)")
    }

    var color: UIColor {
        return condition.color
    }

    var condition: Condition {
        return Condition(health: health)
    }

    var markerPosition: CGPoint {
        return service.markerPosition
    }

    private let service: ServiceType
    private let totalDistance: Int
    private var distanceToRepair: Int {
        max(service.distanceInt + service.lastRepairDistanceInt - totalDistance, 0)
    }

    init(service: ServiceType, totalDistance: Int) {
        self.service = service
        self.totalDistance = totalDistance
    }

    func repair() {
        service.lastRepairDistance = Int64(totalDistance)
        CoreDataManager.shared.saveContext()
    }

    enum Condition {
        case good
        case warning
        case bad

        init(health: Double) {
            if health > 0.66 {
                self = .good
            } else if health > 0.33 {
                self = .warning
            } else {
                self = .bad
            }
        }

        var color: UIColor {
            switch self {
            case .good:
                return .conditionGood
            case .warning:
                return .conditionWarning
            case .bad:
                return .conditionBad
            }
        }
    }
}
