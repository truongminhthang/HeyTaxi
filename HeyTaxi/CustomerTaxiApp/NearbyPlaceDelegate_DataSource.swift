//
//  NearbyPlaceDelegate+DataSource.swift
//  CustomerTaxiApp
//
//  Created by Vu Tinh on 12/22/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit

class NearbyPlaceDelegate_DataSource: BasePlaceDataSource_Delegate {

    var nearbyPlaces: [PlaceModel] = []
    
    override func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNearbyPlace(_:)), name: .passNearbyPlaces , object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func receiveNearbyPlace(_ notification: Notification) {
        guard let nearbyPlaces = notification.userInfo?["nearbyPlaces"] as? [PlaceModel] else {return}
        self.nearbyPlaces = nearbyPlaces
        DispatchQueue.main.async(execute: {
                self.baseSearchPlaceVC.tableView.reloadData()
        })
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlace = nearbyPlaces[indexPath.row]
        super.tableView(tableView, didSelectRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let activePlace = baseSearchPlaceVC.activePlace else {return nil}
        if let name = activePlace.name {
            return "Những điểm gần \(name)"
        } else {
            return "Những điểm gần tọa độ \(activePlace.latitude) - \(activePlace.longitude)"
        }
    }
}

//MARK - UITableViewDataSource

extension NearbyPlaceDelegate_DataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nearbyPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.placeTableCell, for: indexPath)
        configureCell(cell: cell, forRowAt: indexPath)
        return cell
    }
    
    func configureCell(cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.text = nearbyPlaces[indexPath.row].name ?? ""
        cell.detailTextLabel?.text = nearbyPlaces[indexPath.row].address ?? ""
    }

}
