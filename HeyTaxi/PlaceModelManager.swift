//
//  PlaceModeManager.swift
//  HeyTaxi
//
//  Created by Trương Thắng on 2/22/17.
//  Copyright © 2017 Trương Thắng. All rights reserved.
//

import Foundation
import CoreData
import GooglePlaces

class SearchPlaceServices {
    
    var placesClient                = GMSPlacesClient.shared()
    lazy var filter : GMSAutocompleteFilter = {
        let filter = GMSAutocompleteFilter()
        filter.type = .noFilter
        filter.country = "VN"
        return filter
    }()
    var timer: Timer?
    private var _historyPlace :  [PlaceModel]?
    private var historyPlaces : [PlaceModel]? {
        if _historyPlace == nil {
            updateFromDataBase()
        }
        return _historyPlace
    }
    
    @objc func updateFromDataBase() {
        if let placeEntities =  PlaceEntity.getall() {
            if placeEntities.count != 0 {
                _historyPlace = placeEntities.map({ (placeEntity) -> PlaceModel in
                    return PlaceModel(placeEntity: placeEntity)
                })
            }
        }
    }
    var searchResultPlaces: [[PlaceModel]] {
        didSet {
            NotificationCenter.default.post(name: Notification.Name.didChangeDisplayPlaceModels, object: nil)
        }
    }
    private var searchHistoryResult: [PlaceModel] = []
    private var searchPlaceResult : [PlaceModel] = []
    
    var searchText: String = "" {
        didSet {
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.query), userInfo: nil, repeats: false)
        }
    }
    
    init() {
        searchResultPlaces = [[], []]
        if let aHistoryPlaces = self.historyPlaces {
            searchResultPlaces = [aHistoryPlaces, []]
        }
        NotificationCenter.default.addObserver(self, selector: #selector(updateFromDataBase), name: Notification.Name.placeModelHasSaved, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func query() {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            updateFromDataBase()
            searchResultPlaces = [historyPlaces ?? [], []]
        } else {
            searchPlace()
        }
    }
    
    func searchPlace() {
        searchHistoryResult.removeAll()
        
        let searchText = self.searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased().asciiString
        guard searchText != nil else {return}
        if let aHistories = historyPlaces {
            for place in aHistories {
                guard let name = (place.name ?? "").lowercased().asciiString,
                    let address = (place.address ?? "" ).lowercased().asciiString  else {return}
                
                let isMarch = name.contains(searchText!) || address.contains(searchText!)
                if isMarch {
                    searchHistoryResult.append(place)
                }
            }
        }
        placesClient.autocompleteQuery(searchText!, bounds: nil, filter: filter, callback:  handleReturnValue)
    }
    
    func handleReturnValue(results: [GMSAutocompletePrediction]?, error: Error?) {
        guard error == nil else {
            print("Error: Autocomplete " + String(describing: error))
            return
        }
        guard results != nil else {
            return
        }
        searchPlaceResult = []
        for result in results! {
            searchPlaceResult.append(PlaceModel(prediction: result))
        }
        searchResultPlaces = [searchHistoryResult, searchPlaceResult]
    }
    
    func lookUpPlace(by placeID: String) {
        placesClient.lookUpPlaceID(placeID, callback: finishLookupPlaceID)
    }
    
    func finishLookupPlaceID(place: GMSPlace?, error: Error?) {
        guard error == nil else {
            print("Error: LookupPlaceID \(String(describing: error))")
            return
        }
        guard place != nil else {
            return
        }
        let placeModel = PlaceModel(place: place!)
        placeModel.save()
        AppDelegate.shared.mapVC?.mapView.animateToPickedPlace(placeModel: placeModel)
        AppDelegate.shared.windowManager?.isBusy = false
    }
    
}
