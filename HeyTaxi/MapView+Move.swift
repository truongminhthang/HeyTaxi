//
//  MapView+Move.swift
//  HeyTaxi
//
//  Created by Trương Thắng on 2/22/17.
//  Copyright © 2017 Trương Thắng. All rights reserved.
//

import Foundation
import GoogleMaps
import GooglePlaces

extension GMSMapView {
    
    var mapbounds: GMSCoordinateBounds {
        let visibleRegion = self.projection.visibleRegion()
        return GMSCoordinateBounds(coordinate: visibleRegion.farLeft, coordinate: visibleRegion.nearRight)
    }
    
    func animateToPickedPlace(placeModel: PlaceModel) {
        if let viewport = placeModel.viewport {
            self.animate(with: GMSCameraUpdate.fit(viewport))
        } else {
            self.animate(to: GMSCameraPosition.camera(withTarget: placeModel.coordinate, zoom: 16))
        }
    }
    
    func drawMarker(place: GMSPlace, with image: UIImage) {
        let marker = GMSMarker(position: place.coordinate)
        marker.title = place.name
        marker.snippet = place.formattedAddress
        marker.icon = image
        marker.map = self
    }
    func drawMarkerAtCoordinate(coordinate: CLLocationCoordinate2D, with image: UIImage) {
        let marker = GMSMarker(position: coordinate)
        marker.icon = image
        marker.map = self
    }
}
