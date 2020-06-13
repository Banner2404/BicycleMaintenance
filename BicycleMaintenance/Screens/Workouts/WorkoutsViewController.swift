//
//  WorkoutsViewController.swift
//  BicycleMaintenance
//
//  Created by Евгений Соболь on 6/8/20.
//  Copyright © 2020 Esobol. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WorkoutsViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    private var viewModel: WorkoutsViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = WorkoutsViewModel()
        viewModel.workouts
            .drive(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }

}

// MARK: - UITableViewDataSource
extension WorkoutsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfWorkouts
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: WorkoutTableViewCell.self, for: indexPath)
        let workout = viewModel.viewModelForWorkout(at: indexPath.row)
        cell.textLabel?.text = workout.name
        cell.detailTextLabel?.text = workout.distance
        cell.textLabel?.alpha = workout.isHidden ? 0.5 : 1.0
        cell.detailTextLabel?.alpha = workout.isHidden ? 0.5 : 1.0
        return cell
    }
}

// MARK: - UITableViewDelegate
extension WorkoutsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt
        indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let viewModel = self.viewModel.viewModelForWorkout(at: indexPath.row)
        let title = viewModel.isHidden ? "Unarchive" : "Archive"
        let hideAction = UIContextualAction(style: .normal, title: title) { action, view, completion in
            viewModel.toggleHide()
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [hideAction])
    }
}
