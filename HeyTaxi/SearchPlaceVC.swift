//
//  File.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 1/1/17.
//  Copyright © 2017 Trương Thắng. All rights reserved.
//

import UIKit
import CoreLocation

class SearchPlaceVC: BaseTranformableVC  {
    // MARK: OUTLET
    @IBOutlet weak var searchBar: UISearchBar!
    let searchPlaceServices = SearchPlaceServices()
    
    // MARK: - LIFE CYCLE
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSearchBarToNavigationBar()
        AppDelegate.shared.tranformableNav?.displayState = .middle
        registerNotification()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    func registerNotification() {
        NotificationCenter.default.addObserver(forName: Notification.Name.didChangeDisplayPlaceModels, object: nil, queue: nil) { (notification) in
            self.tableView.reloadData()
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func addSearchBarToNavigationBar() {
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar?.delegate = self
        changeSearchbarAppearence(searchbar: searchBar, size: 20)
    }
    
    func changeSearchbarAppearence(searchbar: UISearchBar, size: CGFloat) {
        let textFieldInsideSearchBar = searchbar.value(forKey:"searchField") as! UITextField
        textFieldInsideSearchBar.font = UIFont.systemFont(ofSize: size)
        textFieldInsideSearchBar.textColor = UIColor.white
        textFieldInsideSearchBar.tintColor = UIColor.yellow
    }
    
    // MARK: - NAVIGATION
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
//        case SegueIdentifier.<#id#>:
//            <#code#>
        default:
            return
        }
    }
    
    @IBAction func setMonitorRegion() {
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self), let coordinate = NearbyPlaceHelper.share.coordinate {
            DispatchQueue.main.async {
                LocationManager.shared.stopMonitoring()
                let pickupRegion = CLCircularRegion(center: coordinate , radius: 100, identifier: ZoneID.pickup)
                LocationManager.shared.startMonitoring(for: pickupRegion)
            }
        } else {
            fatalError("Error: CLLocationManager is Monitoring Unavailable")
        }
    }

}

// MARK: - UISearchBarDelegate

extension SearchPlaceVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchPlaceServices.searchText = searchText
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        AppDelegate.shared.tranformableNav?.displayState = .full
    }
}
