//
//  WorkoutRecordViewModel.swift
//  BicycleMaintenance
//
//  Created by Евгений Соболь on 6/8/20.
//  Copyright © 2020 Esobol. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class WorkoutRecordViewModel {

    var name: String {
        return DateFormatter.workout.string(from: workout.date)
    }

    var distance: String {
        return "\(workout.distance) km"
    }

    var isHidden: Bool {
        return workout.isHidden
    }
    
    private let workout: Workout

    init(workout: Workout) {
        self.workout = workout
    }

    func toggleHide() {
        workout.isHidden.toggle()
        CoreDataManager.shared.saveContext()
    }
}
