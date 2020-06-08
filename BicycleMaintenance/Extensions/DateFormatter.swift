//
//  DateFormatter.swift
//  BicycleMaintenance
//
//  Created by Евгений Соболь on 6/8/20.
//  Copyright © 2020 Esobol. All rights reserved.
//

import Foundation

extension DateFormatter {

    static var workout: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        return formatter
    }()
}
