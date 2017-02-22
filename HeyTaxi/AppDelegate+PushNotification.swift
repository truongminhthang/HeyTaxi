//
//  AppDelegate+PushNotification.swift
//  CustomerTaxiApp
//
//  Created by Vu Tinh on 1/18/17.
//  Copyright © 2017 Trương Thắng. All rights reserved.
//
import UIKit
import Foundation
import UserNotifications
import UserNotificationsUI


extension AppDelegate {
    
   
    //MARK: -Remote notification support
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        APNSManager.shared.didReceiveRemoteNotification(application: application, userInfo: userInfo)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        APNSManager.shared.didRegisterForRemoteNotificationsWithDeviceToken(application: application, deviceToken: deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        APNSManager.shared.didFailToRegisterForRemoteNotificationsWithError(application: application, error: error)
    }

}
