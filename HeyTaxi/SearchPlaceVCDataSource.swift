//
//  SearchPlace+TableView.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/19/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit

// MARK: - UITableViewDataSource

extension SearchPlaceVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return searchPlaceServices.searchResultPlaces.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if searchPlaceServices.searchResultPlaces[0].count == 0 {
            return section == 0 ? nil : nil
        } else if searchPlaceServices.searchResultPlaces[1].count != 0{
            return section == 0 ? "Lịch sử" : "Các kết quả khác"
        } else {
            return section == 0 ? "Lịch sử" : nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchPlaceServices.searchResultPlaces[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.placeTableCell, for: indexPath)
        configureCell(cell: cell, forRowAt: indexPath)
        return cell
    }
    
    func configureCell(cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let place = searchPlaceServices.searchResultPlaces[indexPath.section][indexPath.row]
        if indexPath.section == 0 {
            cell.textLabel?.text = place.address
            cell.detailTextLabel?.text =  place.name
        } else {
            cell.textLabel?.text = place.name
            cell.detailTextLabel?.text =  place.address
        }
        
    }
    
}


