//
//  UITableView.swift
//  BicycleMaintenance
//
//  Created by Евгений Соболь on 5/24/20.
//  Copyright © 2020 Esobol. All rights reserved.
//

import UIKit

extension UITableView {

    func dequeueReusableCell<T: UITableViewCell>(ofType type: T.Type, for indexPath: IndexPath) -> T {
        let id = type.identifier
        guard let cell = dequeueReusableCell(withIdentifier: id, for: indexPath) as? T else {
            fatalError("Unable to dequeue cell with identifier " + id)
        }
        return cell
    }

    func registerNib<T: UITableViewCell>(forCellType type: T.Type) {
        let id = String(describing: type)
        let nib = UINib(nibName: id, bundle: nil)
        register(nib, forCellReuseIdentifier: id)
    }

    func registerClass<T: UITableViewCell>(forCellType type: T.Type) {
        let id = String(describing: type)
        register(type, forCellReuseIdentifier: id)
    }
}
