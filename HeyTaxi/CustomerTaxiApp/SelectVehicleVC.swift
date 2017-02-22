//
//  SelectVehicleViewController.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/19/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit

class SelectVehicleVC: UIViewController {
   
    weak var baseSearchPlaceVC: BaseSearchPlaceVC!
    
    // MARK: - LIFE CYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        (navigationController as? TransformNavigationController)?.displayState = .middle
    }
    
    // MARK: - ACTION
    
    @IBAction func callDriverAction(_ sender: UIButton) {
        NotificationCenter.default.post(name: .displayingConnectToDriver, object: nil)
    }
    
    @IBAction func backButtonOnTap() {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
}
