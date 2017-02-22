//
//  MapVC+ConnectDriver.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/30/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit

// MARK: - handle feature connecting with driver and show driver profile

extension MapVC {
    func hiddenOrShowConnectToDriver(_ notification: Notification) {
        viewConnectToDriver.layer.cornerRadius = 6
        showConectToDriver()
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(self.updateTimerToCallDriver), userInfo: nil, repeats: false);
    }
    
    func updateTimerToCallDriver() {
        hiddenConectToDriver()
        let alert = UIAlertController(title: "ABC", message: "ABC", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    func hiddenConectToDriver() {
        viewConnectToDriver.isHidden = true
    }
    
    func showConectToDriver() {
        viewConnectToDriver.isHidden = false
        moveViewBot()
    }
    
    func moveViewBot() {
        UIView.animate(withDuration: 1, delay: 0.1, options: [.curveEaseOut, .allowUserInteraction], animations: {
            var viewConnectToDriverTopFrame = self.viewConnectToDriver.frame
            viewConnectToDriverTopFrame.origin.y -= self.viewConnectToDriver.frame.height - 10
            
            self.viewConnectToDriver.frame = viewConnectToDriverTopFrame
        }) { (finished) in
            self.moveViewTop()
        }
    }
    
    func moveViewTop() {
        UIView.animate(withDuration: 1, delay: 0.1, options: [.curveEaseOut, .allowUserInteraction], animations: {
            var viewConnectToDriverBotFrame = self.viewConnectToDriver.frame
            viewConnectToDriverBotFrame.origin.y += self.viewConnectToDriver.frame.height - 10
            
            self.viewConnectToDriver.frame = viewConnectToDriverBotFrame
        }) { (finished) in
            self.moveViewBot()
        }
    }
}
