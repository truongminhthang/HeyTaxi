//
//  BasePlaceDataSource+Delegate.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/30/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit

extension SearchPlaceVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPlace = searchPlaceServices.searchResultPlaces[indexPath.section][indexPath.row]
        self.searchBar.text = selectedPlace.address
        guard let placeID = selectedPlace.placeID else {
            return
        }
        if !selectedPlace.haslookUpAndUpdate {
            AppDelegate.shared.windowManager?.isBusy = true
            searchPlaceServices.lookUpPlace(by: placeID)
        } else {
            selectedPlace.save()
            AppDelegate.shared.mapVC?.mapView.animateToPickedPlace(placeModel: selectedPlace)
        }
        AppDelegate.shared.tranformableNav?.displayState = .low
        self.searchBar.resignFirstResponder()
    }
}
