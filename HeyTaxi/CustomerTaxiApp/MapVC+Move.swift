//
//  MapVC+Move.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/15/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker

// MARK: - Move and Animate Map View

extension MapVC {
    
    func drawPolyline(places:[PlaceModel]) {
        guard places.count > 1 else {return}
        mapView.clear()
        if let sourceCoordinate = places.first?.coordinate {
            drawMarker(coordinate: sourceCoordinate, with: #imageLiteral(resourceName: "CurrentPoint"))
        }

        for (index, place) in places.enumerated() {
            guard index + 1 < places.count else {return}
            let destinationLocation = places[index + 1 ].coordinate
            drawMarker(coordinate: destinationLocation, with: #imageLiteral(resourceName: "PoiMarker"))
            DirectionServices().queryDirection(source: place.coordinate, target: destinationLocation, callBack: drawPolyline)
        }
        let bound = GMSCoordinateBounds(coordinate: (places.first?.coordinate)!, coordinate: (places.last?.coordinate)!)
        let cameraUpdate = GMSCameraUpdate.fit(bound, withPadding: 5)
        mapView.animate(with: cameraUpdate)
    }
    
    func drawPolyline(json: Dictionary<String, AnyObject>) {
        guard let routes = json["routes"] as? [Dictionary<String, AnyObject>] else {
            return
        }
        guard let route = routes.first?["overview_polyline"] as? Dictionary<String, AnyObject> else {
            return
        }
        guard let overview_route = route["points"] as? String else {
            return
        }
        let path = GMSPath(fromEncodedPath: overview_route)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 5
        polyline.strokeColor = UIColor.black.withAlphaComponent(0.5)
        polyline.map = mapView
    }
    
    func animateToCurrentPlace() {
        guard currentLocation != nil else { return }
        mapView.animate(to: GMSCameraPosition(target: currentLocation!.coordinate, zoom: zoomLevel, bearing: 0, viewingAngle: 0))
    }
    
    func animateToPickedPlace(placeModel: PlaceModel) {
        buildingRouteHelper?.displayPlace = placeModel
        if let viewport = placeModel.viewport {
            self.mapView.animate(with: GMSCameraUpdate.fit(viewport))
        } else {
            self.mapView.animate(to: GMSCameraPosition(target: placeModel.coordinate, zoom: 16, bearing: 0, viewingAngle: 0))
        }
    }
    
    func drawMarker(place: GMSPlace, with image: UIImage) {
        let marker = GMSMarker(position: place.coordinate)
        marker.title = place.name
        marker.snippet = place.formattedAddress
        marker.icon = image
        marker.map = self.mapView
    }
    func drawMarker(coordinate: CLLocationCoordinate2D, with image: UIImage) {
        let marker = GMSMarker(position: coordinate)
        marker.icon = image
        marker.map = self.mapView
    }

}
