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
            updateWidthConstraint()
        }
    }
    private let fillContainer = UIView()
    private let fillView = UIView()
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
        NSLayoutConstraint.activate([
            fillContainer.leftAnchor.constraint(equalTo: leftAnchor, constant: cornerRadius),
            rightAnchor.constraint(equalTo: fillContainer.rightAnchor, constant: cornerRadius),
            fillContainer.topAnchor.constraint(equalTo: topAnchor),
            fillContainer.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        addSubview(fillView)
        fillView.layer.cornerRadius = cornerRadius
        fillView.backgroundColor = UIColor.green
        fillView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fillView.leftAnchor.constraint(equalTo: leftAnchor),
            fillView.topAnchor.constraint(equalTo: topAnchor),
            fillView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        updateWidthConstraint()
    }

    func updateWidthConstraint() {
        widthConstraint?.isActive = false
        widthConstraint = fillView.widthAnchor.constraint(
            equalTo: fillContainer.widthAnchor,
            multiplier: CGFloat(progress),
            constant: 2 * cornerRadius
        )
        widthConstraint?.isActive = true
    }
}
