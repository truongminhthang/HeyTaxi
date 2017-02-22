//
//  APNSManager.swift
//  HeyTaxi
//
//  Created by Trương Thắng on 2/22/17.
//  Copyright © 2017 Trương Thắng. All rights reserved.
//

import UIKit

let notificationInfoDispatchID = "dispatchId"

class APNSManager: NSObject {
    static let shared = APNSManager()
    
    public func registerRemoteNotification() {
        let settings =  UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        UIApplication.shared.registerForRemoteNotifications()
        UIApplication.shared.registerUserNotificationSettings(settings)
    }
    
    public func unregisterRemoteNotification() {
        UIApplication.shared.unregisterForRemoteNotifications()
    }
    
    func processContentOfRemoteNotification(payload: [AnyHashable : Any]) {
        if let aps = payload["aps"] as? [String : AnyObject] {
            let alertBody = (aps["alert"] as? String) ?? ""
            let alertController = UIAlertController(title: "Thông báo", message: alertBody, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            AppDelegate.shared.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    func didReceiveRemoteNotification(application: UIApplication, userInfo: [AnyHashable : Any]) {
        print("Notification ===> \(userInfo)")
        DispatchQueue.main.async {
            self.processContentOfRemoteNotification(payload: userInfo)
        }
        
    }
    
    func didFailToRegisterForRemoteNotificationsWithError(application: UIApplication, error: Error) {
        print("!!!!!failed to register notification!!!!! : \(error)")
    }
    
    
    
    func didRegisterForRemoteNotificationsWithDeviceToken(application: UIApplication, deviceToken: Data) {
        let token = String.loadFromUserDefaults(withKey: UserDefaultKey.deviceToken)
        if token == "" {
            var pushToken = String(format: "%@", deviceToken as CVarArg)
            pushToken = pushToken.trimmingCharacters(in: CharacterSet(charactersIn: "<>"))
            pushToken = pushToken.replacingOccurrences(of: " ", with: "")
            pushToken.saveToUserDefaults(withKey: UserDefaultKey.deviceToken)
            
            let params = ["device_token":pushToken,
                          "device_token_type":"capns"]
            
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            guard let url = URL(string: "http:\\abc.cm") else {return}
            var request = URLRequest(url: url)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.httpMethod = "POST"
            let jsonData = try! JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions(rawValue: 0))
            request.httpBody = jsonData
            let sessionDataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
                
            })
            sessionDataTask.resume()
            
        }
    }
}


