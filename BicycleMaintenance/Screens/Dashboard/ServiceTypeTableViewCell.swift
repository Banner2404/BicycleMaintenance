//
//  ServiceTypeTableViewCell.swift
//  BicycleMaintenance
//
//  Created by Евгений Соболь on 5/24/20.
//  Copyright © 2020 Esobol. All rights reserved.
//

import UIKit

class ServiceTypeTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLeftLabel: UILabel!
    @IBOutlet weak var serviceImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        serviceImageView.layer.cornerRadius = 5
        serviceImageView.layer.borderWidth = 1
        serviceImageView.layer.borderColor = UIColor.border.cgColor
    }
}
