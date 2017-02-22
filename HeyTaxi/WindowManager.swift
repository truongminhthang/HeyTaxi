//
//  WindowManager.swift
//  HeyTaxi
//
//  Created by Trương Thắng on 2/22/17.
//  Copyright © 2017 Trương Thắng. All rights reserved.
//

import UIKit

class WindowManager: NSObject {
    unowned var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    var timer = Timer()
    lazy var busyView: UIView = {
        let busyView = UIView()
        busyView.frame = self.window.frame
        busyView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        activity.startAnimating()
        activity.center = busyView.center
        busyView.addSubview(activity)
        
        return busyView
    }()
    var isBusy: Bool = false {
        didSet {
            if isBusy {
                configBusyState()
                delayCallMethodAfter(time: 10)
            } else {
                configAvailableState()
            }
        }
    }
    func delayCallMethodAfter(time: TimeInterval) {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(setBusyIsFalse), userInfo: nil, repeats: false)
    }
    
    func setBusyIsFalse() {
        DispatchQueue.main.async {
            self.isBusy = false
        }
    }
    
    func configBusyState() {
        window.addSubview(busyView)
    }
    
    func configAvailableState() {
        busyView.removeFromSuperview()
    }
}
