//
//  LocalNotificationManager.swift
//  HeyTaxi
//
//  Created by Trương Thắng on 2/22/17.
//  Copyright © 2017 Trương Thắng. All rights reserved.
//

import Foundation
import UserNotifications
import UserNotificationsUI


class LocalNotificationManager: NSObject {
    static let shared : LocalNotificationManager = LocalNotificationManager()
    let requestIdentifier = "localNotification"
    func triggerNotification(title: String, body: String, imageName: String = "", delay: TimeInterval = 1) {
        if #available(iOS 10.0, *) {
            let content = UNMutableNotificationContent()
            content.title = "title"
            content.body = "Did Exit pickup Region"
            content.sound = UNNotificationSound.default()
            content.badge = (UIApplication.shared.applicationIconBadgeNumber  + 1) as NSNumber
            
            //To Present image in notification
            if let path = Bundle.main.path(forResource: imageName, ofType: "png") {
                let url = URL(fileURLWithPath: path)
                do {
                    let attachment = try UNNotificationAttachment(identifier: imageName, url: url, options: nil)
                    content.attachments = [attachment]
                } catch {
                    print("attachment not found.")
                }
            }
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: delay, repeats: false)
            let request = UNNotificationRequest(identifier:requestIdentifier, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().add(request){(error) in
                if (error != nil){
                    print(error!.localizedDescription)
                }
            }
        } else {
            var localNotification = UILocalNotification()
            localNotification.fireDate = Date().addingTimeInterval(delay)
            localNotification.alertTitle = title
            localNotification.alertBody = body
            localNotification.timeZone = NSTimeZone.default
            localNotification.applicationIconBadgeNumber = UIApplication.shared.applicationIconBadgeNumber + 1
            
            UIApplication.shared.scheduleLocalNotification(localNotification)
            
        }
        
    }
}


// MARK: - UNUserNotificationCenterDelegate

@available(iOS 10.0, *)
extension LocalNotificationManager: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("Tapped in notification")
    }
    
    //This is key callback to present notification while the app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("Notification being triggered")
        //You can either present alert ,sound or increase badge while the app is in foreground too with ios 10
        //to distinguish between notifications
        if notification.request.identifier == requestIdentifier{
            
            completionHandler( [.alert,.sound,.badge])
        }
    }
}
