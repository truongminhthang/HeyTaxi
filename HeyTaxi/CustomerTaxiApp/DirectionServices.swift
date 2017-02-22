//
//  DirectionServices.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/15/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit
import CoreLocation

class DirectionServices: NSObject {
    func queryDirection(source: CLLocationCoordinate2D, target: CLLocationCoordinate2D, callBack:@escaping(_ dict: Dictionary<String, AnyObject>) -> ()) {
        let urlString = "https://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(target.latitude),\(target.longitude)&key=\(AppConstant.googleMapkey)"
        guard let url = URL(string: urlString) else {return }
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
                    guard let dict = try JSONSerialization.jsonObject(with: aData, options: []) as? Dictionary<String, AnyObject> else {
                        print("error trying to convert data to JSON")
                        return
                    }
                    callBack(dict)
                } catch let error {
                    print(error)
                }
            }
        }
        task.resume()
    }
}
