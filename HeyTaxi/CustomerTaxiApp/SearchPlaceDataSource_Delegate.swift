//
//  SearchPlace+TableView.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/19/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit

// MARK: - UITableViewDelegate

class SearchPlaceDataSource_Delegate: BasePlaceDataSource_Delegate {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlace = placeModelManager.displayPlace[indexPath.section][indexPath.row]
        super.tableView(tableView, didSelectRowAt: indexPath)
    }
}

// MARK: - UITableViewDataSource

extension SearchPlaceDataSource_Delegate: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if placeModelManager.displayPlace[0].count == 0 {
            return section == 0 ? nil : "Các kết quả khác"
        } else if placeModelManager.displayPlace[1].count != 0{
            return section == 0 ? "Lịch sử" : "Các kết quả khác"
        } else {
            return section == 0 ? "Lịch sử" : nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeModelManager.displayPlace[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.placeTableCell, for: indexPath)
        configureCell(cell: cell, forRowAt: indexPath)
        return cell
    }
    
    func configureCell(cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let place = placeModelManager.displayPlace[indexPath.section][indexPath.row]
        cell.textLabel?.text = place.name
        cell.detailTextLabel?.text = place.address
    }
}


