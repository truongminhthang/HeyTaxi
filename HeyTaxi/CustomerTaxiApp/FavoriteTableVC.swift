//
//  FavoriteTableVC.swift
//  CustomerTaxiApp
//
//  Created by admin on 12/12/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit

class FavoriteTableVC: UITableViewController {
    
    var displayFavoritePlace: [PlaceEntity] = []

    override func viewDidLoad() {
        super.viewDidLoad()
//
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
////        self.tableView.isUserInteractionEnabled = false
//        
    }
}

// MARK: - TableViewDataSource
extension FavoriteTableVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayFavoritePlace.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "FavoriteTableCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let place = displayFavoritePlace[indexPath.row]
        cell.textLabel?.text = place.name ?? ""
        cell.detailTextLabel?.text = place.address ?? ""
        
        return cell
    }
    
}







