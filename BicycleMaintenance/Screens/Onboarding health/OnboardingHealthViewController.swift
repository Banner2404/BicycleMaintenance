//
//  OnboardingHealthViewController.swift
//  BicycleMaintenance
//
//  Created by Евгений Соболь on 6/13/20.
//  Copyright © 2020 Esobol. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class OnboardingHealthViewController: UIViewController {

    private var viewModel: OnboardingHealthViewModel!
    private let disposeBag = DisposeBag()
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var connectButton: OnboardingButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        isModalInPresentation = true
        setupImageView()
        viewModel = OnboardingHealthViewModel()
        viewModel.viewController = self
        viewModel.isConnecting
            .map { !$0 }
            .drive(connectButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }

    @IBAction private func connectButtonTap(_ sender: Any) {
        viewModel.connect()
    }

    private func setupImageView() {
        imageView.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowOffset = CGSize(width: 0, height: 1)
        imageView.layer.shadowRadius = 3.0 / 2.0
    }
}
