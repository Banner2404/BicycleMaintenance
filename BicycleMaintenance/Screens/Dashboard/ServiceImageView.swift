//
//  ServiceImageView.swift
//  BicycleMaintenance
//
//  Created by Евгений Соболь on 5/24/20.
//  Copyright © 2020 Esobol. All rights reserved.
//

import UIKit

class ServiceImageView: UIView {

    let imageView = UIImageView()
    let badgeView = ServiceBadgeView()

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
private extension ServiceImageView {

    func setup() {
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.border.cgColor
        clipsToBounds = true

        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.attachToFrame(of: self)

        addSubview(badgeView)
        badgeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            badgeView.leadingAnchor.constraint(equalTo: leadingAnchor),
            badgeView.topAnchor.constraint(equalTo: topAnchor),
            badgeView.widthAnchor.constraint(equalToConstant: 24),
            badgeView.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
