//
//  BasePlaceDataSource+Delegate.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/30/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit

class BasePlaceDataSource_Delegate: NSObject, UITableViewDelegate {
    unowned var baseSearchPlaceVC: BaseSearchPlaceVC
    var selectedPlace : PlaceModel?
    let placeModelManager = PlaceModelManager(mapVC: AppDelegate.share.mapVC!)
    init(baseSearchPlaceVC: BaseSearchPlaceVC) {
        self.baseSearchPlaceVC = baseSearchPlaceVC
        super.init()
        registerNotification()
    }
    
    func registerNotification() {
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard selectedPlace != nil else {return}
        guard let placeID = selectedPlace!.placeID else {
            return
        }
        baseSearchPlaceVC.activePlace = selectedPlace
        if !selectedPlace!.haslookUpAndUpdate {
            AppDelegate.share.isBusy = true
            placeModelManager.lookUpPlace(by: placeID)
        } else {
            selectedPlace!.save()
            baseSearchPlaceVC.transformNAV.mapVC?.animateToPickedPlace(placeModel: selectedPlace!)
        }
        baseSearchPlaceVC.transformNAV.displayState = .middle
        baseSearchPlaceVC.searchMode = .nearby
        baseSearchPlaceVC.searchBar.resignFirstResponder()
        (baseSearchPlaceVC as? SearchPlaceVC)?.addMoreButton?.isEnabled = true
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
}
