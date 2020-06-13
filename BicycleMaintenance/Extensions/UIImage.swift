//
//  UIImage.swift
//  BicycleMaintenance
//
//  Created by Евгений Соболь on 6/13/20.
//  Copyright © 2020 Esobol. All rights reserved.
//

import UIKit

extension UIImage {

    static func roundedImage(with color: UIColor?, radius: CGFloat) -> UIImage? {
        guard let color = color else { return nil }
        let scale = UIScreen.main.scale
        let size = radius * 2 + 1
        UIGraphicsBeginImageContextWithOptions(CGSize(width: size, height: size), false, scale)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: size, height: size), cornerRadius: radius).cgPath
        context?.addPath(path)
        context?.fillPath()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image?.resizableImage(withCapInsets: UIEdgeInsets(all: radius)) ?? UIImage()
    }
}
