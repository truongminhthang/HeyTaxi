//
//  AppConstant.swift
//  TaxiCustomer
//
//  Created by Trương Thắng on 12/6/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import Foundation

struct AppConstant {
    static let googleMapkey = "AIzaSyDKhbCGnX_13oih7aaCmeQ9z-PNbFvrxxM"
    static let googlePlaceKey = "AIzaSyCvDbbv6NDwX6v5qFbcu9zTCFzGieg0jiQ"
    static let googleSearchPlaceWebService = "AIzaSyBOMbC8nBUxZVRkwULgoflot2U5s0y3XGw"
}

struct SegueIdentifier {
    static let embedQuickSelectCollection       = "embedQuickSelectCollection"
    static let embedSelectVehicleCollectionVC   = "embedSelectVehicleCollectionVC"
    static let embedPaymentTableVC              = "embedPaymentTableVC"
    static let embedSideMenu                    = "embedSideMenu"
    static let embedMapContainerVC              = "embedMapContainerVC"
    static let embedMapVC                       = "embedMapVC"
    static let embedNavigation                  = "embedNavigation"
    static let embedMainMenu                    = "embedMainMenu"
    static let embedPageView                    = "embedPageView"
    static let embedSearchPlaceVC                = "embedSearchPlaceVC"
    
    static let showTripHistories                = "showTripHistories"
    static let showAddPayment                   = "showAddPayment"
    static let showOrderTaxi                    = "showOrderTaxi"
    static let showUserInfo                     = "showUserInfo"
    static let showBecomeCooperationVC          = "showBecomeCooperationVC"
    static let showSupportVC                    = "showSupportVC"
    static let showSearchPlace                  = "showSearchPlace"
    static let showFavoriteTableVC              = "showFavoriteTableVC"
    static let showSelectVehicle                = "showSelectVehicle"
    static let showAddDestinatePlace = "ShowAddDestinatePlace"
    
    static let showRouteManagement              = "showRouteManagement"

    static let popupAddPromotion                = "popupAddPromotion"
    static let backToMainMenuVC                 = "backToMainMenuVC"
    static let showEditPlace                    = "showEditPlace"
    static let showNewPlace                     = "showNewPlace"

}

struct CellID {
    static let placeTableCell             = "PlaceTableCell"
    static let quickSelectCollectionCell        = "QuickSelectCollectionCell"
    static let selectVehicleCell                = "SelectVehicleCell"
    static let addMorePaymentTableCell          = "AddMorePaymentTableCell"
    static let paymentCell                      = "PaymentCell"
    static let historyTableCell                 = "HistoryTableCell"
    static let defaultCollectionCell            = "defaultCollectionCell"
    static let routeCell            = "routeCell"

    
}
extension Notification.Name {
    static let toggleMenuDidTap       = Notification.Name("toggleMenuDidTap")
    static let confirmPickUpPlace         = Notification.Name("confirmPickUpPlace")
    static let didChangeDisplayPlaceModels      = Notification.Name("didChangeDisplayPlaceModels")
    static let placeModelHasSaved                 = Notification.Name("placeModelHasSaved")
    static let displayingModeDidChange                 = Notification.Name("displayingModeDidChange")
    static let passNearbyPlaces     = Notification.Name("passNearbyPlaces")
    static let displayingConnectToDriver = Notification.Name("displayingConnectToDriver")
    static let changeMapState           = Notification.Name("changeMapState")
    static let updateRoute              = Notification.Name("updateRoute")
    static let destinationMarkerDidTap  = Notification.Name("destinationMarkerDidTap")
    static let didTapAtCoordinate       = Notification.Name("didTapAtCoordinate")
}

struct UserInfoKey {
    static let place = "place"
    static let mapState = "MapState"
}

struct URLString {
    static let googleDirectionURLString = "https://maps.googleapis.com/maps/api/directions/json?origin=Toronto&destination=Montreal&key=" + AppConstant.googlePlaceKey
}




