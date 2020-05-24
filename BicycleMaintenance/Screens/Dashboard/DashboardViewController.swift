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

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DashboardViewModel()
        viewModel.services
            .drive(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.loadData()
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


