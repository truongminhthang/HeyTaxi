//
//  AppConstant.swift
//  HelloGloco
//
//  Created by Trương Thắng on 2/21/17.
//  Copyright © 2017 Trương Thắng. All rights reserved.
//

import Foundation


struct AppConstant {
    static let googleMapkey = "AIzaSyCtxUsSCA_3uNcQJutY5stnPuC3k1Wm_K4"
    static let googlePlaceKey = "AIzaSyD7ffkuMRtoB36nw5zlKAikdqvmHkAkMDw"
    static let googleSearchPlaceWebService = "AIzaSyBOMbC8nBUxZVRkwULgoflot2U5s0y3XGw"

}

//
//  AppConstant.swift
//  TaxiCustomer
//
//  Created by Trương Thắng on 12/6/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import Foundation

struct UserDefaultKey {
    
    static let email          = "email"
    static let id             = "id"
    static let name           = "name"
    static let phoneNumber    = "phoneNumber"
    static let deviceToken    = "deviceToken"
    static let fistName       = "first_name"
    static let lastName       = "last_name"
    static let givenName      = "givenName"
    static let familyName     = "familyName"
    static let avatarImage    = "avatarImage"
    static let createDate     = "createDate"
    static let updatedDate    = "updatedDate"
    static let type           = "type"
    
}

struct SegueIdentifier {
    static let embedMapVC       = "embedMapVC"
    static let embedTranfromableVC = "embedTranfromableVC"
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
    static let didEnterDropDownZone = Notification.Name("didEnterDropDownZone")
    static let didExitPickupZone    = Notification.Name("didExitPickupZone")
    static let changeToNearbySearchMode = Notification.Name("changeToNearbySearchMode")

}

struct ZoneID {
    static let pickup = "Pick Up Zone"
    static let drop = "Drop down Zone"
}
//
//struct NotificationKey {
//    static let toggleMenuDidTap       = "toggleMenuDidTap"
//    static let confirmPickUpPlace         = "confirmPickUpPlace"
//    static let didChangeDisplayPlaceModels      = "didChangeDisplayPlaceModels"
//    static let placeModelHasSaved                 = "placeModelHasSaved"
//    static let displayingModeDidChange                 = "displayingModeDidChange"
//    static let passNearbyPlaces     = "passNearbyPlaces"
//    static let displayingConnectToDriver = "displayingConnectToDriver"
//    static let changeMapState           = "changeMapState"
//    static let updateRoute              = "updateRoute"
//    static let destinationMarkerDidTap  = "destinationMarkerDidTap"
//    static let didTapAtCoordinate       = "didTapAtCoordinate"
//    static let didExitPickupZone = "didExitPickupZone"
//    static let didEnterDropDownZone = "didEnterDropDownZone"
//    static let changeToNearbySearchMode = "changeToNearbySearchMode"
//}

struct UserInfoKey {
    static let place = "place"
    static let mapState = "MapState"
}

struct AlertString {
    static let connectingWithDriver     = "Đang kết nối với tài xế ..."
    static let moveMapForPickPlace      = "Di chuyển Bản đồ \nđể chọn vị trí chính xác hơn"
    static let inform                   = "Thông báo"
    static let checkNetwork             = "Bạn hãy kiểm tra lại kết nối mạng của bạn"
    static let driverComming            = "Tài xế đang đến"
    static let retryNetwork             = "Retry"
    static let checkInform              = "Bạn hãy điền đầy đủ thông tin"
}

//USER DEFAULT KEY
let CURRENT_TOKEN = "CURRENT_TOKEN"
