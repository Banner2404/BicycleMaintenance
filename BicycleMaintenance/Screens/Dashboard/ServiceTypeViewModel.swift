//
//  ServiceTypeViewModel.swift
//  BicycleMaintenance
//
//  Created by Евгений Соболь on 5/24/20.
//  Copyright © 2020 Esobol. All rights reserved.
//

import Foundation

class ServiceTypeViewModel {

    var name: String {
        service.name ?? ""
    }

    var distanceLeft: String {
        "\(distanceToRepair) km left"
    }

    var health: Double {
        Double(distanceToRepair) / Double(service.distanceInt)
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
