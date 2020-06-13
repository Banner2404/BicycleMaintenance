//
//  OnboardingButton.swift
//  BicycleMaintenance
//
//  Created by Евгений Соболь on 6/13/20.
//  Copyright © 2020 Esobol. All rights reserved.
//

import UIKit

class OnboardingButton: UIButton {

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}

// MARK: - Private
private extension OnboardingButton {

    func setup() {
        let background = UIImage.roundedImage(with: .onboardingGreen, radius: 10)
        setBackgroundImage(background, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 26, weight: .medium)
    }
}
