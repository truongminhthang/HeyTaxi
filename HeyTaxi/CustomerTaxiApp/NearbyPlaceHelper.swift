//
//  SearchPlaceServices.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/28/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import Foundation
import GooglePlaces

class NearbyPlaceHelper {
    unowned var mapVC: MapVC
    var timer: Timer?
    var nearbyPlaces : [PlaceModel] = []
    var coordinate: CLLocationCoordinate2D? {
        didSet {
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 0.4 , target: self, selector: #selector(self.searchNearByPlace), userInfo: nil, repeats: false)
        }
    }
    
    var currentCoorinate: CLLocationCoordinate2D? {
        didSet {
            requestNearbyPlaceForCurrentPlace(callBack: handleReturnedJSONForCurrentPlace)
        }
    }
    
    init(mapVC: MapVC) {
        self.mapVC = mapVC
    }
    
    @objc func searchNearByPlace() {
        requestNearbyPlace(callBack: handleReturnedJSON)
    }
    
    func handleReturnedJSON (_ dictionaries: [Dictionary<String, AnyObject>]) {
        for dictionary in dictionaries {
            let placeModel = PlaceModel(dictionary: dictionary)
            nearbyPlaces.append(placeModel)
        }
        if nearbyPlaces.first != nil {
            mapVC.buildingRouteHelper.displayPlace = nearbyPlaces.first
        }
        NotificationCenter.default.post(name: .passNearbyPlaces, object: nil, userInfo: ["nearbyPlaces": nearbyPlaces])
        return
    }
    
    func handleReturnedJSONForCurrentPlace(_ dictionaries: [Dictionary<String, AnyObject>]) {
        if let currentDictionary = dictionaries.first {
            let placeModel = PlaceModel(dictionary: currentDictionary)
            mapVC.buildingRouteHelper.addStartPlace(startPlace: placeModel)
        }
    }
    
    func requestNearbyPlace(callBack:@escaping([Dictionary<String, AnyObject>]) -> Void) {
        nearbyPlaces.removeAll()
        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(self.coordinate!.latitude),\(self.coordinate!.longitude)&type=point_of_interest&radius=70&languages=vi&key=\(AppConstant.googleSearchPlaceWebService)"
        request(urlString: urlString, callBack: callBack)
    }
    
    func requestNearbyPlaceForCurrentPlace(callBack:@escaping([Dictionary<String, AnyObject>]) -> Void) {
        nearbyPlaces.removeAll()
        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(self.currentCoorinate!.latitude),\(self.currentCoorinate!.longitude)&type=point_of_interest&radius=70&languages=vi&key=\(AppConstant.googleSearchPlaceWebService)"
        request(urlString: urlString, callBack: callBack)
    }

    
    func request(urlString: String, callBack:@escaping([Dictionary<String, AnyObject>]) -> Void) {
        guard let url = URL(string: urlString) else {return}
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error: HTTPResponse has no value")
                return
            }
            
            if httpResponse.statusCode == 200 {
                guard let aData = data else {
                    print("Error: did not receive data")
                    return
                }
                do {
                    let dictionaries = try JSONSerialization.jsonObject(with: aData, options: []) as? Dictionary<String, AnyObject>
                    guard let aDictionaries = dictionaries?["results"] as? [Dictionary<String, AnyObject>] else {
                        print("Error: trying to convert data to JSON")
                        return
                    }
                    callBack(aDictionaries)
                } catch let error {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    
    
}
