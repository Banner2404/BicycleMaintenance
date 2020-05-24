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
        service.name ?? ""
    }

    var distanceLeft: String {
        "\(distanceToRepair) km left"
    }

    var serviceDistance: String {
        "\(service.distance) km"
    }

    var health: Double {
        Double(distanceToRepair) / Double(service.distanceInt)
    }

    var image: UIImage? {
        return UIImage(named: "Services/\(service.image!)")
    }

    var badge: UIImage? {
        return UIImage(named: "Badges/\(service.badge!)")
    }

    var color: UIColor {
        if health > 0.66 {
            return .conditionGood
        } else if health > 0.33 {
            return .conditionWarning
        } else {
            return .conditionBad
        }
    }

    private let service: ServiceType
    private let totalDistance: Int
    private var distanceToRepair: Int {
        max(service.distanceInt - totalDistance, 0)
    }

    init(service: ServiceType, totalDistance: Int) {
        self.service = service
        self.totalDistance = totalDistance
    }
}
