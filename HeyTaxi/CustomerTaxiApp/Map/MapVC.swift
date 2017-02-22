//
//  MapVC.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/6/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//
import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker

enum MapState: Int {
    case search
    case nearby
}

class MapVC: UIViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var viewConnectToDriver: UIView!
    @IBOutlet weak var mapContainer: MapContainerVC!
    @IBOutlet weak var topOfConnectToDriverConstraintLayout: NSLayoutConstraint!
    var nearbyPlaceHelper : NearbyPlaceHelper!
    var currentLocation: CLLocation?
    var startPlace: CLLocation?
    var destinationPlace: CLLocation?
    var placesClient = GMSPlacesClient.shared()
    var zoomLevel: Float = 15.0
    var buildingRouteHelper : BuildingRouteHelper!
    var search_MapViewDelegate = Search_MapViewDelegate()
    var timer = Timer()
    
    lazy var nearby_MapViewDelegate : Nearby_MapViewDelegate = {
        return Nearby_MapViewDelegate(nearbyPlaceHelper: self.nearbyPlaceHelper)
    }()
    
    var mapbounds:GMSCoordinateBounds? {
        if let visibleRegion = mapView?.projection.visibleRegion() {
            return GMSCoordinateBounds(coordinate: visibleRegion.farLeft, coordinate: visibleRegion.nearRight)
        }
        return nil
    }
    
    var mapState: MapState = .search {
        didSet {
            guard mapState != oldValue else {return}
            switch mapState {
            case .search:
                mapView.delegate = search_MapViewDelegate
            case .nearby:
                mapView.delegate = nearby_MapViewDelegate
            }
        }
    }
    
    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        locationManager.delegate = self
        return locationManager
     }()
    

    
    // MARK: - LIFE CYCLE
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buildingRouteHelper = BuildingRouteHelper(mapVC: self)
        nearbyPlaceHelper = NearbyPlaceHelper(mapVC: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenConectToDriver()
        let _ = locationManager
        setupMapView()
        registerNotification()
    }
    
    func setupMapView() {
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.delegate = search_MapViewDelegate
        
        // Add the map to the view, hide it until we've got a location update.
        mapView.isHidden = true
    }
    
    func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(getPlace(_:)), name: .confirmPickUpPlace, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hiddenOrShowConnectToDriver(_:)), name: .displayingConnectToDriver, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - ACTION
    
    func getPlace(_ notification: Notification) {
        if let place = notification.userInfo?[UserInfoKey.place] as? PlaceModel {
            animateToPickedPlace(placeModel: place)
        }
        mapContainer.confirmDestinateButton.isHidden = false 
        
    }
}


