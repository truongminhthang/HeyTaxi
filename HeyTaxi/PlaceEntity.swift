//
//  PlaceEntity.swift
//  HeyTaxi
//
//  Created by Trương Thắng on 2/22/17.
//  Copyright © 2017 Trương Thắng. All rights reserved.
//


import Foundation
import CoreData
import GooglePlaces

extension PlaceEntity {
    
    class func searchRequest(placeID: String) -> NSFetchRequest<PlaceEntity> {
        let fetch = NSFetchRequest<PlaceEntity>(entityName: "PlaceEntity");
        fetch.predicate = NSPredicate(format: "placeID == %@",placeID)
        return fetch
    }
    
    static func makeInstance() -> PlaceEntity {
        if #available(iOS 10.0, *) {
            return PlaceEntity(context: AppDelegate.shared.context)
        } else {
            return NSEntityDescription.insertNewObject(forEntityName: "PlaceEntity", into: AppDelegate.shared.context) as! PlaceEntity
        }
    }
    
    static func getall() -> [PlaceEntity]? {
        let request: NSFetchRequest<PlaceEntity> = PlaceEntity.fetchRequest()
        return try? AppDelegate.shared.context.fetch(request)
    }
    
    static func search(by placeID: String) -> PlaceEntity? {
        let searchRequest: NSFetchRequest<PlaceEntity> = PlaceEntity.searchRequest(placeID: placeID)
        return (try? AppDelegate.shared.context.fetch(searchRequest))?.first
    }
    
}
