//
//  TripManagement.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 1/1/17.
//  Copyright © 2017 Trương Thắng. All rights reserved.
//

import UIKit

class RouteManagementVC: BaseBottomMenuVC  {
    static var identifier = "RouteManagementVC"
    static var instance : RouteManagementVC {
        let storyboard = UIStoryboard(name: "Map", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: RouteManagementVC.identifier) as! RouteManagementVC
    }
    weak var buildingRouteHelper : BuildingRouteHelper!
    
    @IBOutlet var bottomContainer: UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildingRouteHelper = transformNAV.mapVC?.buildingRouteHelper
        tableView.rowHeight = 63
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        navigationController?.isNavigationBarHidden = false
        transformNAV.mapContainerVC?.confirmDestinateButton.isHidden = true

    }

     override func registerNotification() {
        super.registerNotification()
        NotificationCenter.default.addObserver(self, selector: #selector(updateRoute), name: .updateRoute, object: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case SegueIdentifier.showEditPlace:
            if let indexPath = tableView.indexPathForSelectedRow {
                buildingRouteHelper.currentIndex = indexPath.row
                let place = buildingRouteHelper.places[indexPath.row]
                mapVC?.animateToPickedPlace(placeModel: place)
            }
        case SegueIdentifier.showNewPlace:
                buildingRouteHelper.currentIndex = buildingRouteHelper.places.count
        default:
            return
        }
    }
    
    // MARK: - ACTION
    
    @IBAction func confirmRoute() {
        
    }
    
    @IBAction func setEditing() {
        let editing = !self.isEditing
        super.setEditing(editing, animated: true)
        tableView.setEditing(editing, animated: true)
    }
    
    
    func updateRoute() {
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
        })
    }
}

//MARK: UITableViewDelegate

extension RouteManagementVC: UITableViewDelegate {
    
    // Called after the user changes the selection.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        buildingRouteHelper.swap(fromPlace: sourceIndexPath.row, toPlaceAt: destinationIndexPath.row)
        
    }
}

// MARK: - UITableViewDataSource

extension RouteManagementVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buildingRouteHelper.places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.routeCell, for: indexPath) as! RouteCell
        configureCell(cell: cell, forRowAtIndexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: RouteCell, forRowAtIndexPath indexPath: IndexPath) {
        let place = buildingRouteHelper.places[indexPath.row]
        cell.titleLabel?.text = place.name
        cell.addressLabel?.text = place.address
        switch indexPath.row {
        case 0:
            cell.iconView?.image = #imageLiteral(resourceName: "Start")
        case buildingRouteHelper.places.count - 1:
            cell.iconView?.image = #imageLiteral(resourceName: "End")
        default:
            cell.iconView?.image = #imageLiteral(resourceName: "Middle")
            
        }
        cell.iconView?.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 55, height: 56))
        
    }
}
