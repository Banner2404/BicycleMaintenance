//
//  ServiceBadgeView.swift
//  BicycleMaintenance
//
//  Created by Евгений Соболь on 5/24/20.
//  Copyright © 2020 Esobol. All rights reserved.
//

import UIKit

class ServiceBadgeView: UIView {

    let imageView = UIImageView()

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
private extension ServiceBadgeView {

    func setup() {
        layer.cornerRadius = 5
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.border.cgColor
        layer.maskedCorners = [.layerMaxXMaxYCorner]
        backgroundColor = .white

        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.attachToFrame(of: self)
    }
}
