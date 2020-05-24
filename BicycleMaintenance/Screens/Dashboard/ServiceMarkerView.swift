//
//  ServiceMarkerView.swift
//  BicycleMaintenance
//
//  Created by Евгений Соболь on 5/24/20.
//  Copyright © 2020 Esobol. All rights reserved.
//

import UIKit

class ServiceMarkerView: UIView {

    let imageView = UIImageView()
    private let size: CGFloat

    init(size: CGFloat) {
        self.size = size
        super.init(frame: .zero)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        self.size = 20
        super.init(coder: aDecoder)
        setup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = size / 2
    }
}

// MARK: - Private
private extension ServiceMarkerView {

    func setup() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.attachToFrame(of: self)
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: size),
            heightAnchor.constraint(equalToConstant: size)
        ])
    }
}
