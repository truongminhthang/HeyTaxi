//
//  BuildingTripHelper.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/31/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import GoogleMaps

class BuildingRouteHelper: NSObject {
    var currentIndex = 1
    unowned var mapVC: MapVC
    var displayPlace: PlaceModel?
    var places: [PlaceModel] = [] {
        didSet {
            NotificationCenter.default.post(name: .updateRoute, object: nil)
            mapVC.drawPolyline(places: places)
        }
    }
    
    init(mapVC: MapVC) {
        self.mapVC = mapVC
        super.init()
    }

    
    
    func addStartPlace(startPlace: PlaceModel) {
        if places.first == nil {
            places.append(startPlace)
        } else {
            places[0] = startPlace
        }
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            
        }
        mapVC.stopMonitoring()
        let identiferEnter = "Pick Up Zone"
        let latitude = 21.033482264310027
        let longitude = 105.76990842819214
        let regionEnter = CLCircularRegion(center:  CLLocationCoordinate2D(latitude: latitude, longitude: longitude), radius: 100, identifier: identiferEnter)
        regionEnter.notifyOnEntry = true
        regionEnter.notifyOnExit = true
        mapVC.locationManager.startMonitoring(for: regionEnter)
       

    }
    
    func addDestinate() {
        guard let aDisplayPlace = displayPlace else {return}
        aDisplayPlace.save()
        if currentIndex >= places.count {
            places.append(aDisplayPlace)
        } else {
            places[currentIndex] = aDisplayPlace
        }
    }
    
    func swap(fromPlace fromIndex: Int, toPlaceAt toIndex: Int) {
        let temp = places[fromIndex]
        places[fromIndex] = places[toIndex]
        places[toIndex] = temp
    }
    
    func editDetinate(at index: Int) {
        guard index < places.count else {return}
        guard displayPlace != nil else {return}
        places[index] = displayPlace!
    }
    
    func removeDestinate(at index: Int) {
        guard index < places.count else {return}
        places.remove(at: index)
    }
    
    

    
}
