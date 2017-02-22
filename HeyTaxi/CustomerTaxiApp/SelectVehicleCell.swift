//
//  SelectVehicleCell.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/19/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit

class SelectVehicleCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var carTypeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        carTypeLabel.text = ""
        priceLabel.text = ""
    }
}
