//
//  SearchPlaceResultTableVC.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/6/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit

class HistoryBaseTableVC: UITableViewController {
    
    var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configSearchController()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func configSearchController() {
        searchController.searchResultsUpdater = self
        tableView.tableHeaderView = searchController.searchBar
        searchController.dimsBackgroundDuringPresentation = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
     // MARK: - Navigation
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHistoryDetail" {
            
        }
     }
    
    /*
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

// MARK: - UISearchResultsUpdating

extension HistoryBaseTableVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.isActive && searchController.searchBar.text! != "" {
            // TODO: 
//            displayedTrips = tripHelper.historyTrips
        } else {
//            displayedTrips = tripHelper.historyTrips
        }
        tableView.reloadData()
    }
}

// MARK: - TableViewDelegate

extension HistoryBaseTableVC {
    
}

// MARK: - TableViewDataSource

extension HistoryBaseTableVC {
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return displayedTrips.count
        return 0
    }
    
}
