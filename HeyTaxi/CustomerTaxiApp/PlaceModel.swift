//
//  PlaceModel.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/6/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import Foundation
import CoreData
import GooglePlaces


struct PlaceModel {
    var name: String?
    var address: String?
    var placeID: String?
    var types: [String]?
    var latitude: Double = 0
    var longitude: Double = 0
    var northEastLatitude : Double = 0
    var northEastLongitude: Double = 0
    var southWestLatitude: Double = 0
    var southWestLongitude: Double = 0
    var rating : Float = 0.0
    
    init(prediction: GMSAutocompletePrediction) {
        self.name      = prediction.attributedPrimaryText.string
        self.address    = prediction.attributedSecondaryText?.string ?? ""
        self.placeID    = prediction.placeID
        self.types      = prediction.types
    }
    
    init(coordinate: CLLocation) {
        self.latitude = coordinate.coordinate.latitude
        self.longitude = coordinate.coordinate.longitude
    }
    
    init(coordinate2D: CLLocationCoordinate2D ) {
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }
    
    init(place: GMSPlace) {
        self.name               = place.name
        self.address            = place.formattedAddress
        self.placeID            = place.placeID
        self.types              = place.types
        self.latitude           = place.coordinate.latitude
        self.longitude          = place.coordinate.longitude
        self.northEastLatitude   = place.viewport?.northEast.latitude ?? 0
        self.northEastLongitude  = place.viewport?.northEast.longitude ?? 0
        self.southWestLatitude   = place.viewport?.southWest.latitude ?? 0
        self.southWestLongitude  = place.viewport?.southWest.longitude ?? 0
        self.rating             = place.rating
    }
    init(placeEntity: PlaceEntity) {
        self.name                = placeEntity.name
        self.address             = placeEntity.address
        self.placeID             = placeEntity.placeID
        self.types               = placeEntity.types
        self.latitude            = placeEntity.latitude
        self.longitude           = placeEntity.longitude
        self.northEastLatitude   = placeEntity.northEastLatitude
        self.northEastLongitude  = placeEntity.northEastLongitude
        self.southWestLatitude   = placeEntity.southWestLatitude
        self.southWestLongitude  = placeEntity.southWestLongitude
        self.rating             = placeEntity.rating
    }
    
    init(dictionary: Dictionary<String,AnyObject>) {
        
        self.name                = dictionary["name"] as? String
        self.address             = dictionary["vicinity"] as? String
        self.placeID             = dictionary["place_id"] as? String
        self.types               = dictionary["types"] as? [String]
        
        let geometryDict        = dictionary["geometry"] as? Dictionary<String,AnyObject>
        let locationDict        = geometryDict?["location"] as? Dictionary<String,AnyObject>
        
        self.latitude            = (locationDict?["lat"] as? Double) ?? 0
        self.longitude           = (locationDict?["lng"] as? Double) ?? 0
        
        let viewportDict        = geometryDict?["viewport"] as? Dictionary<String,AnyObject>
        let northeastDict       = viewportDict?["northeast"] as? Dictionary<String,AnyObject>
        let southwestDict       =  viewportDict?["southwest"] as? Dictionary<String,AnyObject>
        self.northEastLatitude   = ( northeastDict?["lat"] as? Double) ?? 0
        self.northEastLongitude  = (northeastDict?["lng"] as? Double) ?? 0

        self.southWestLatitude   = ( southwestDict?["lat"] as? Double) ?? 0
        self.southWestLongitude  = (southwestDict?["lng"] as? Double) ?? 0
        self.rating             = (dictionary["rating"] as? Float ) ?? 0
    }
    
    func save() {
        guard self.placeID != nil else {return}
        var placeEntity: PlaceEntity
        if let aPlaceEntity = PlaceEntity.search(by: self.placeID!) {
            placeEntity = aPlaceEntity
        } else {
            placeEntity = PlaceEntity.makeInstance()
        }
        placeEntity.name                = self.name
        placeEntity.address             = self.address
        placeEntity.placeID             = self.placeID
        placeEntity.types               = self.types
        placeEntity.latitude            = self.latitude
        placeEntity.longitude           = self.longitude
        placeEntity.northEastLatitude   = self.northEastLatitude
        placeEntity.northEastLongitude  = self.northEastLongitude
        placeEntity.southWestLatitude   = self.southWestLatitude
        placeEntity.southWestLongitude  = self.southWestLongitude
        AppDelegate.share.saveContext()
    }
}

// MARK: -

extension PlaceModel {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var viewport: GMSCoordinateBounds? {
        guard northEastLatitude != 0, northEastLongitude != 0, southWestLatitude != 0, southWestLongitude != 0  else {return nil}
        let northEast = CLLocationCoordinate2D(latitude: northEastLatitude, longitude: northEastLongitude)
        let southWest = CLLocationCoordinate2D(latitude: southWestLatitude, longitude: southWestLongitude)
        return GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
    }
    
    var haslookUpAndUpdate: Bool {
        return latitude != 0
    }
    
    static func == (left: PlaceModel, right: PlaceModel) -> Bool {
        return left.latitude == right.latitude && left.longitude == right.longitude
    }
    
    static func != (left: PlaceModel, right: PlaceModel) -> Bool {
        return left.latitude != right.latitude && left.longitude != right.longitude
    }
}

