//
//  UIColor.swift
//  BicycleMaintenance
//
//  Created by Евгений Соболь on 5/24/20.
//  Copyright © 2020 Esobol. All rights reserved.
//

import UIKit

extension UIColor {

    static var border: UIColor {
        UIColor(151, 151, 151)
    }

    static var conditionGood: UIColor {
        UIColor.green
    }

    static var conditionBad: UIColor {
        UIColor.red
    }

    convenience init(_ r: Int, _ g: Int, _ b: Int) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
    }
}
