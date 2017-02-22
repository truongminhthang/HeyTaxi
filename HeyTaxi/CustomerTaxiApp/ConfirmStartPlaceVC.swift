//
//  SearchPlaceTableVC.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/9/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces



enum SearchMode {
    case nearby
    case search
}

class ConfirmStartPlaceVC: BaseBottomMenuVC {
    
    // MARK: - ACTION
    
    @IBAction func confirmPlaceButtonDidTap() {
        transformNAV.displayState = .middle
        NotificationCenter.default.post(name: .confirmPickUpPlace, object: nil)
    }
   
}



