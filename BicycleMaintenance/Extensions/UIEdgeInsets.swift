//
//  UIEdgeInsets.swift
//  BicycleMaintenance
//
//  Created by Евгений Соболь on 6/13/20.
//  Copyright © 2020 Esobol. All rights reserved.
//

import UIKit

extension UIEdgeInsets {

    init(all: CGFloat) {
        self.init(top: all, left: all, bottom: all, right: all)
    }

    init(vertical: CGFloat) {
        self.init(top: vertical, left: 0, bottom: vertical, right: 0)
    }

    init(horizontal: CGFloat) {
        self.init(top: 0, left: horizontal, bottom: 0, right: horizontal)
    }
}
