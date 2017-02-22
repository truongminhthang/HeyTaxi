//
//  SelectCountryVC.swift
//  CustomerTaxiApp
//
//  Created by Vu Tinh on 12/12/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit

class SelectCountryVC: UITableViewController {

    var arrayCountry = ["Việt Nam", "Luân đôn", "Mỹ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayCountry.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectCountryTableCell", for: indexPath) as! SelectCountryTableCell
            cell.nameCountryLabel.text = arrayCountry[indexPath.row]
        // Configure the cell...

        return cell
    }
}
