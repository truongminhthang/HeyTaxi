//
//  MapVC+MapViewDelegate.swift
//  HeyTaxi
//
//  Created by Trương Thắng on 2/22/17.
//  Copyright © 2017 Trương Thắng. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

extension MapVC: GMSMapViewDelegate {
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        return true
    }
    
    // MARK: - set up view map
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {

    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        NearbyPlaceHelper.share.coordinate = position.target
    }
    
    
}
