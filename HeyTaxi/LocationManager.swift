//
//  MapVC+LocalManagerDelegate.swift
//  HeyTaxi
//
//  Created by Trương Thắng on 2/22/17.
//  Copyright © 2017 Trương Thắng. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces


class LocationManager: CLLocationManager, CLLocationManagerDelegate {
    
    static let shared : LocationManager = LocationManager()
    let requestIdentifier = "SampleRequest"
    
    override init() {
        super.init()
        self.desiredAccuracy = kCLLocationAccuracyBest
        self.requestAlwaysAuthorization()
        self.distanceFilter = 50
        self.startUpdatingLocation()
        self.delegate = self
        registerNotification()

        
    }
    
    deinit {
        self.delegate = nil
        NotificationCenter.default.removeObserver(self)
    }
    
    func registerNotification() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationWillResignActive, object: nil, queue: nil) { [unowned self] (notification) in
            if CLLocationManager.significantLocationChangeMonitoringAvailable() {
                self.stopUpdatingLocation()
                self.startMonitoringSignificantLocationChanges()
            } else {
                // Error: Significant location change monitoring is not available
            }
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationWillEnterForeground, object: nil, queue: nil) { [unowned self](notification) in
            if CLLocationManager.significantLocationChangeMonitoringAvailable() {
                self.stopMonitoringSignificantLocationChanges()
                self.startUpdatingLocation()
            } else {
                // Error: Significant location change monitoring is not available
            }
        }
    }
    
    // Handle incoming location events.
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentCoordinate = locations.first?.coordinate else {return}
        
        NearbyPlaceHelper.share.coordinate = currentCoordinate
        let camera = GMSCameraPosition.camera(withTarget: currentCoordinate, zoom: 18)
        DispatchQueue.main.async {
            AppDelegate.shared.mapVC?.mapView.animate(to: camera)
        }
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            // Start the standard location service.
            manager.startUpdatingLocation()
        }
    }
    
    // Handle location manager errors.
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if let circularRegion = region as? CLCircularRegion {
            if circularRegion.identifier == ZoneID.drop {
                LocalNotificationManager().triggerNotification(title: "Thông báo", body: "Bạn đã đến nơi", imageName: "", delay: 1)

            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if let circularRegion = region as? CLCircularRegion {
            if circularRegion.identifier == ZoneID.pickup {
               LocalNotificationManager().triggerNotification(title: "Thông báo", body: "Chúc các bạn có 1 chuyến đi vui vẻ", imageName: "", delay: 1)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("monitoringDidFailFor region: \(String(describing: region?.description)); error: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("didStartMonitoringFor region: \(region.description)")
    }
    
    func stopMonitoring() {
        for region in self.monitoredRegions {
            if let circularRegion = region as? CLCircularRegion {
                self.stopMonitoring(for: circularRegion)
            }
        }
    }
}


