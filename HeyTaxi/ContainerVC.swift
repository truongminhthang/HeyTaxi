//
//  ContainerVC.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/14/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit
import CoreLocation

enum MenuType: Int {
    case quickSelect
    case orderTaxi
    case confirmPlace
}

class ContainerVC: UIViewController {
    @IBOutlet weak var corverView: UIView!
    @IBOutlet weak var heightBottomSheetConstraint: NSLayoutConstraint!
    var heightBottomSheetConstant : CGFloat = 360 {
        didSet {
            heightBottomSheetConstraint.constant = heightBottomSheetConstant
        }
    }
    
    let locationManager = LocationManager.shared
    // MARK: - LIFE CYCLE
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            
        case .denied:
            let alertController = UIAlertController(title: "Location services", message: "Location services were previously denied by the user. Please enable location services for this app in settings.", preferredStyle: .alert)
            let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                            print("Settings opened: \(success)") // Prints true
                        })
                    } else {
                        UIApplication.shared.openURL(settingsUrl)
                        
                    }
                }
            }
            alertController.addAction(settingsAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        default:
            locationManager.startUpdatingLocation()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case SegueIdentifier.embedMapVC:
            AppDelegate.shared.mapVC = segue.destination as? MapVC
        case SegueIdentifier.embedTranfromableVC:
            AppDelegate.shared.tranformableNav = segue.destination as? TranformableNAV
            
        default:
            return
        }
    }
}
