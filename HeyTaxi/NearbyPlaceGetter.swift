//
//  NearbyPlaceGetter.swift
//  HeyTaxi
//
//  Created by Trương Thắng on 2/22/17.
//  Copyright © 2017 Trương Thắng. All rights reserved.
//


import Foundation
import GooglePlaces

class NearbyPlaceHelper: NSObject {
    static let share : NearbyPlaceHelper = NearbyPlaceHelper()
    var timer: Timer?
    var nearbyPlaces : [PlaceModel] = []
    var coordinate: CLLocationCoordinate2D? {
        didSet {
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.searchNearByPlace), userInfo: nil, repeats: false)
        }
    }
    
    @objc func searchNearByPlace() {
        requestNearbyPlace(callBack: handleReturnedJSON)
    }
    
    func handleReturnedJSON (dictionaries: [Dictionary<String, AnyObject>]) {
        for dictionary in dictionaries {
            let placeModel = PlaceModel(dictionary: dictionary)
            
            nearbyPlaces.append(placeModel)
            if nearbyPlaces.count == 1 {
                DispatchQueue.main.async {
                    AppDelegate.shared.mapVC?.currentPlaceLabel?.text = self.nearbyPlaces.first?.address ?? ""
                }
            }
        }
    }
    
    func requestNearbyPlace(callBack:@escaping ([Dictionary<String, AnyObject>]) -> Void) {
        nearbyPlaces.removeAll()
        if let coordinate = self.coordinate {
            let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(coordinate.latitude),\(coordinate.longitude)&type=point_of_interest&radius=50&languages=vi&key=\(AppConstant.googleSearchPlaceWebService)"
            request(urlString: urlString, callBack: callBack)
        }
    }
    
    func request(urlString: String, callBack:@escaping ([Dictionary<String, AnyObject>]) -> Void) {
        guard let url = URL(string: urlString) else {return}
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url)  { (data, response, error) in
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
                    guard let dictionaries = try JSONSerialization.jsonObject(with: aData, options: []) as? Dictionary<String, AnyObject> else {
                        print("error trying to convert data to JSON")
                        return
                    }
                    guard let aDictionaries = dictionaries["results"] as? [Dictionary<String, AnyObject>] else {
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

