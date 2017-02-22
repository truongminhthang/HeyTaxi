//
//  File.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 1/1/17.
//  Copyright © 2017 Trương Thắng. All rights reserved.
//

import UIKit

class BaseSearchPlaceVC: BaseBottomMenuVC  {
    // MARK: OUTLET
    @IBOutlet weak var searchHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchPlaceDataSource_Delegate : SearchPlaceDataSource_Delegate!
    var nearbyPlaceDataSource_Delegate : NearbyPlaceDelegate_DataSource!
    var activePlace: PlaceModel?
    var searchMode : SearchMode = .nearby {
        didSet {
            switch searchMode {
            case .nearby:
                tableView.delegate = nearbyPlaceDataSource_Delegate
                tableView.dataSource = nearbyPlaceDataSource_Delegate
                transformNAV.mapVC?.mapState = .nearby
                
            case .search:
                tableView.delegate = searchPlaceDataSource_Delegate
                tableView.dataSource = searchPlaceDataSource_Delegate
                transformNAV.mapVC?.mapState = .search

                
            }
            tableView.reloadData()
        }
    }
    
    // MARK: - LIFE CYCLE
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        searchPlaceDataSource_Delegate = SearchPlaceDataSource_Delegate (baseSearchPlaceVC: self)
        nearbyPlaceDataSource_Delegate = NearbyPlaceDelegate_DataSource(baseSearchPlaceVC: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSearchBarToNavigationBar()
        setupOriginValue()
        transformNAV.displayState = .middle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func registerNotification() {
        super.registerNotification()
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveAutocompleteData), name: .didChangeDisplayPlaceModels, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setSearchModeToNearby), name: .didTapAtCoordinate, object: nil)

    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupOriginValue() {
        searchMode = .nearby
    }
    
    func addSearchBarToNavigationBar() {
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar?.delegate = self
        changeSearchbarAppearence(searchbar: searchBar, size: 20)
    }
    
    func changeSearchbarAppearence(searchbar: UISearchBar, size: CGFloat) {
        let textFieldInsideSearchBar = searchbar.value(forKey: "searchField") as! UITextField
        textFieldInsideSearchBar.font = UIFont.systemFont(ofSize: size)
        textFieldInsideSearchBar.textColor = UIColor.white
        textFieldInsideSearchBar.tintColor = UIColor.yellow
    }
    
    // MARK: - NAVIGATION
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case SegueIdentifier.showSelectVehicle:
            let selectVehicle = segue.destination as? SelectVehicleVC
            selectVehicle?.baseSearchPlaceVC = self
            transformNAV.displayState = .middle
            
        default:
            return
        }
    }
    
    // MARK: - CALL BACK
    
    @objc func didReceiveAutocompleteData() {
        tableView.reloadData()
    }
    
    func setSearchModeToNearby() {
        searchMode = .nearby
    }
}

// MARK: - UISearchBarDelegate

extension BaseSearchPlaceVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchMode != .search {
            searchMode = .search
        }
        searchPlaceDataSource_Delegate.placeModelManager.searchText = searchText
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        transformNAV.displayState = .full
        searchMode = .search
    }
}
