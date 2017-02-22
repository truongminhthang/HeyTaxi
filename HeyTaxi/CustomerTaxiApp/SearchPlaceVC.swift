//
//  ConfirmStartPlaceVC.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/24/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit

class SearchPlaceVC :BaseSearchPlaceVC{
    
    @IBOutlet weak var addMoreButton: UIButton!
    @IBOutlet weak var confirmRouteButton: UIButton!
    static var identifier = "SearchPlaceVC"
    static var instance : SearchPlaceVC {
        let storyboard = UIStoryboard(name: "Map", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: SearchPlaceVC.identifier) as! SearchPlaceVC
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
    }
    
    override func registerNotification() {
        super.registerNotification()
        NotificationCenter.default.addObserver(self, selector: #selector(add), name: .destinationMarkerDidTap, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        transformNAV.mapContainerVC?.confirmDestinateButton.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setupOriginValue() {
        searchMode = .search
    }

    @IBAction func add() {
        mapVC?.buildingRouteHelper?.addDestinate()
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch  segue.identifier ?? "" {
        case SegueIdentifier.showRouteManagement:
            let routeManagementVC = segue.destination as? RouteManagementVC
            routeManagementVC?.buildingRouteHelper = mapVC?.buildingRouteHelper
        default:
            return
        }
    }

}
