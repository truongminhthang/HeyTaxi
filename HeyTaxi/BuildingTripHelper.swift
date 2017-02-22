////
////  BuildingTripHelper.swift
////  CustomerTaxiApp
////
////  Created by Trương Thắng on 12/31/16.
////  Copyright © 2016 Trương Thắng. All rights reserved.
////
//
//import GoogleMaps
//
//class BuildingRouteHelper: NSObject {
//    var currentIndex = 1
//    var displayPlace: PlaceModel?
//    static let share : BuildingRouteHelper = BuildingRouteHelper()
//    var places: [PlaceModel] = [] {
//        didSet {
//            NotificationCenter.default.post(name: NSNotification.Name.updateRoute, object: nil)
//
//        }
//    }
//    
//    var distance: Double = 0 {
//        didSet {
//            
//        }
//    }
//    
//   
//    func addStartPlace(startPlace: PlaceModel) {
//        if places.first == nil {
//            places.append(startPlace)
//        } else {
//            places[0] = startPlace
//        }
//    }
//    
//    func addDestinate() {
//        guard let aDisplayPlace = displayPlace else {return}
//        aDisplayPlace.save()
//        if currentIndex >= places.count {
//            places.append(aDisplayPlace)
//        } else {
//            places[currentIndex] = aDisplayPlace
//        }
//    }
//    
//    func swap(fromPlace fromIndex: Int, toPlaceAt toIndex: Int) {
//        let temp = places[fromIndex]
//        places[fromIndex] = places[toIndex]
//        places[toIndex] = temp
//    }
//    
//    func editDetinate(at index: Int) {
//        guard index < places.count else {return}
//        guard displayPlace != nil else {return}
//        places[index] = displayPlace!
//    }
//    
//    func removeDestinate(at index: Int) {
//        guard index < places.count else {return}
//        places.remove(at: index)
//    }
//    
//    func setMonitoringRegion() {
//        guard places.count > 1 else {return}
//        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
//            DispatchQueue.main.async {
//                LocationManager.shared.stopMonitoring()
//                let pickupRegion = CLCircularRegion(center: self.places.first!.coordinate , radius: 100, identifier: ZoneID.pickup)
//                LocationManager.shared.startMonitoring(for: pickupRegion)
//                
//                let dropRegion = CLCircularRegion(center: self.places.last!.coordinate , radius: 500, identifier: ZoneID.drop)
//                LocationManager.shared.startMonitoring(for: dropRegion)
//            }
//        } else {
//            fatalError("Error: CLLocationManager is Monitoring Unavailable")
//        }
//
//    }
//}
