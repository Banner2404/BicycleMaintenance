//
//  HealthBar.swift
//  BicycleMaintenance
//
//  Created by Евгений Соболь on 5/24/20.
//  Copyright © 2020 Esobol. All rights reserved.
//

import UIKit

class HealthBar: UIView {

    var progress: Double = 0 {
        didSet {
            updateProgress()
        }
    }
    let fillView = UIView()

    private let fillContainer = UIView()
    private var widthConstraint: NSLayoutConstraint?
    private let cornerRadius: CGFloat = 5

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
private extension HealthBar {

    func setup() {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.border.cgColor

        addSubview(fillContainer)
        fillContainer.translatesAutoresizingMaskIntoConstraints = false
        fillContainer.attachToFrame(of: self, insets: .init(top: 0, left: cornerRadius, bottom: 0, right: cornerRadius))

        addSubview(fillView)
        fillView.layer.cornerRadius = cornerRadius
        fillView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fillView.leftAnchor.constraint(equalTo: leftAnchor),
            fillView.topAnchor.constraint(equalTo: topAnchor),
            fillView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        updateProgress()
    }

    func updateProgress() {
        widthConstraint?.isActive = false
        widthConstraint = fillView.widthAnchor.constraint(
            equalTo: fillContainer.widthAnchor,
            multiplier: CGFloat(progress),
            constant: 2 * cornerRadius
        )
        widthConstraint?.isActive = true
    }
}
