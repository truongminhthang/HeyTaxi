//
//  MapVC+LocationManagerDelegate.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/30/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit
import GoogleMaps


extension MapVC: CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        DispatchQueue.main.async(execute: {
            guard self.nearbyPlaceHelper?.currentCoorinate == nil else {return}
            guard let currentLocation = locations.last else { return }
            self.nearbyPlaceHelper?.currentCoorinate = currentLocation.coordinate
            let camera = GMSCameraPosition.camera(withLatitude: currentLocation.coordinate.latitude,
                                                  longitude: currentLocation.coordinate.longitude,
                                                  zoom: 18)
            if self.mapView.isHidden {
                self.mapView.isHidden = false
                self.mapView.camera = camera
            } else {
                self.mapView.animate(to: camera)
            }
        })
        
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("didEnterRegion: \(region.description)")
        if let circularRegion = region as? CLCircularRegion {
            _ = circularRegion.identifier
            let alertController = UIAlertController(title: "DidEnter", message: "massage", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            mapContainer.present(alertController, animated: true, completion: nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("didExitRegion: \(region.description)")
        if let circularRegion = region as? CLCircularRegion {
            _ = circularRegion.identifier
            let alertController = UIAlertController(title: "didExit", message: "massage", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            mapContainer.present(alertController, animated: true, completion: nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("monitoringDidFailFor region: \(region?.description); error: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("didStartMonitoringFor region: \(region.description)")
    }
    
    func stopMonitoring() {
        for region in locationManager.monitoredRegions {
            if let circularRegion = region as? CLCircularRegion {
                locationManager.stopMonitoring(for: circularRegion)
            }
        }
    }
}
