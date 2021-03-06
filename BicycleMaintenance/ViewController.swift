//
//  DashboardViewController.swift
//  BicycleMaintenance
//
//  Created by Евгений Соболь on 5/19/20.
//  Copyright © 2020 Esobol. All rights reserved.
//

import UIKit
import HealthKit

class DashboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        WorkoutDataManager.shared.authorizeHealthKit { _ in
            WorkoutDataManager.shared.loadTotalDistance { distance in
                print(distance)
            }
        }
    }

}

