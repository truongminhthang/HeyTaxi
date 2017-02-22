//
//  MapVC+GMDelegate.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/11/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit
import GoogleMaps


// MARK: - GMSMapViewDelegate

class Nearby_MapViewDelegate: NSObject, GMSMapViewDelegate {
    
    
    // MARK: - set up view map
    unowned var nearbyPlaceHelper: NearbyPlaceHelper
    init(nearbyPlaceHelper: NearbyPlaceHelper) {
        self.nearbyPlaceHelper = nearbyPlaceHelper
        super.init()
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
       nearbyPlaceHelper.coordinate = position.target
    }
}


class Search_MapViewDelegate: NSObject, GMSMapViewDelegate {
    
    // MARK: - set up view map
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        NotificationCenter.default.post(name: .didTapAtCoordinate, object: nil)

    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {

    }
}
