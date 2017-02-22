//
//  SelectCountryTableCell.swift
//  CustomerTaxiApp
//
//  Created by Vu Tinh on 12/12/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit

class SelectCountryTableCell: UITableViewCell {

    @IBOutlet weak var nameCountryLabel: UILabel!
    @IBOutlet weak var imageCountry: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
