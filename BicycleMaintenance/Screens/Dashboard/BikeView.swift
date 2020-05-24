//
//  BikeView.swift
//  BicycleMaintenance
//
//  Created by Евгений Соболь on 5/24/20.
//  Copyright © 2020 Esobol. All rights reserved.
//

import UIKit

class BikeView: UIView {

    let imageView = UIImageView()
    var markerViews: [ServiceMarkerView] = []

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup(markers: [Marker]) {
        markerViews.forEach { $0.removeFromSuperview() }
        markerViews = []
        markers.forEach { add($0) }
    }

    struct Marker {
        let position: CGPoint
        let condition: ServiceTypeViewModel.Condition
    }
}

// MARK: - Private
private extension BikeView {

    func setup() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.attachToFrame(of: self, insets: .init(top: 16, left: 16, bottom: 16, right: 16))
        imageView.image = UIImage(named: "bike")
    }

    func add(_ marker: Marker) {
        let size: CGFloat = marker.condition == .bad ? 30 : 10
        let image: UIImage? = marker.condition == .bad ? UIImage(named: "error_sign") : nil

        let markerView = ServiceMarkerView(size: size)
        markerView.backgroundColor = marker.condition.color
        markerView.imageView.image = image
        addSubview(markerView)
        markerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(
                item: markerView,
                attribute: .centerX,
                relatedBy: .equal,
                toItem: imageView,
                attribute: .centerX,
                multiplier: marker.position.x * 2,
                constant: 0
            ),
            NSLayoutConstraint(
                item: markerView,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: imageView,
                attribute: .centerY,
                multiplier: marker.position.y * 2,
                constant: 0
            )
        ])
        markerViews.append(markerView)
    }
}
