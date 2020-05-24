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

    private let service: ServiceType

    init(service: ServiceType) {
        self.service = service
    }
}
