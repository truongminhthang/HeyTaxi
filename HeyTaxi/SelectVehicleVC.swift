////
////  SelectVehicleViewController.swift
////  CustomerTaxiApp
////
////  Created by Trương Thắng on 12/19/16.
////  Copyright © 2016 Trương Thắng. All rights reserved.
////
//
//import UIKit
//
//class SelectVehicleVC: UIViewController {
//   
//    weak var baseSearchPlaceVC: BaseSearchPlaceVC!
//    
//    // MARK: - LIFE CYCLE
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(userDidExitPickupZone), name: NotificationKey.didExitPickupZone, object: nil)
//                BuildingRouteHelper.share.prepareDispatchWithLocation()
//    }
//    
//    deinit {
//        NSNotificationCenter.defaultCenter().removeObserver(self)
//    }
//    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//       
//    }
//    
//    // MARK: - ACTION
//    
//    @IBAction func callDriverAction(sender: UIButton) {
//        BuildingRouteHelper.share.callDriver()
//
//    }
//    
//    @IBAction func backButtonOnTap() {
//        dismissViewControllerAnimated(true) {
//        }
//    }
//    
//    func userDidExitPickupZone() {
//        performSegueWithIdentifier(SegueIdentifier.showIntripProgress, sender: nil)
//    }
//    
//}
