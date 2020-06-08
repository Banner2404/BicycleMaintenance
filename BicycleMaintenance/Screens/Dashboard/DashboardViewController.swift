//
//  DashboardViewController.swift
//  BicycleMaintenance
//
//  Created by Евгений Соболь on 5/19/20.
//  Copyright © 2020 Esobol. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DashboardViewController: UIViewController {

    private var viewModel: DashboardViewModel!
    private let disposeBag = DisposeBag()
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var bikeView: BikeView!
    @IBOutlet private weak var loadingView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DashboardViewModel()
        viewModel.services
            .drive(onNext: { [weak self] viewModels in
                self?.reloadData(viewModels)
            })
            .disposed(by: disposeBag)

        viewModel.isLoading
            .map { !$0 }
            .drive(loadingView.rx.isHidden)
            .disposed(by: disposeBag)
        viewModel.isLoading
            .drive(tableView.rx.isHidden)
            .disposed(by: disposeBag)
    }

    private func reloadData(_ viewModels: [ServiceTypeViewModel]) {
        tableView.reloadData()
        reloadMarkers(viewModels)
    }

    private func reloadMarkers(_ viewModels: [ServiceTypeViewModel]) {
        let markers = viewModels.map { BikeView.Marker(position: $0.markerPosition, condition: $0.condition) }
        bikeView.setup(markers: markers)
    }

    private func showRepairAlert(forRow row: Int) {
        let alert = UIAlertController(title: "Repair this part?", message: nil, preferredStyle: .alert)
        let repairAction = UIAlertAction(title: "Repair", style: .default) { [weak self] _ in
            self?.viewModel.viewModelForService(at: row).repair()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(repairAction)
        alert.addAction(cancelAction)
        alert.preferredAction = repairAction
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension DashboardViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfServices
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: ServiceTypeTableViewCell.self, for: indexPath)
        let serviceViewModel = viewModel.viewModelForService(at: indexPath.row)
        cell.nameLabel.text = serviceViewModel.name
        cell.distanceLeftLabel.text = serviceViewModel.distanceLeft
        cell.totalDistanceLabel.text = serviceViewModel.serviceDistance
        cell.serviceImageView.imageView.image = serviceViewModel.image
        cell.serviceImageView.badgeView.imageView.image = serviceViewModel.badge
        cell.serviceImageView.badgeView.imageView.tintColor = serviceViewModel.color
        cell.healthBar.fillView.backgroundColor = serviceViewModel.color
        cell.healthBar.progress = serviceViewModel.health
        return cell
    }
}

// MARK: - UITableViewDelegate
extension DashboardViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showRepairAlert(forRow: indexPath.row)
    }
}
