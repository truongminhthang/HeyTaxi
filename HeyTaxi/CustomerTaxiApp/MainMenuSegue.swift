//
//  MainMenuSegue.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/10/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit

class MainMenuSegue : UIStoryboardSegue, UIViewControllerTransitioningDelegate {
    override func perform() {
        
        //set the ViewControllers for the animation
        let sourceView = self.source.view as UIView!
        let displayRect = sourceView!.frame
        let window = UIApplication.shared.delegate?.window!
        let hideRect = displayRect.offsetBy(dx: 0, dy: window!.frame.height)
        let newDisplayRect = hideRect.offsetBy(dx: 0, dy: -displayRect.height)
        let destinationView = self.destination.view as UIView!
        
        //set the destination View center
        destinationView?.frame = hideRect
        
        // the Views must be in the Window hierarchy, so insert as a subview the destionation above the source
        window?.insertSubview(destinationView!, aboveSubview: sourceView!)
        
        //create UIAnimation- change the views's position when present it
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [.allowUserInteraction, .curveEaseInOut], animations: {
            destinationView?.frame = newDisplayRect
        }, completion: { (isSuccess) in
            self.source.navigationController?.pushViewController(self.destination, animated: false)
        })
    }
}

class ConnectDriverSegue : UIStoryboardSegue, UIViewControllerTransitioningDelegate {
    override func perform() {
        
        //set the ViewControllers for the animation
        let sourceView = self.source.view as UIView!
        let displayRect = sourceView!.frame
        let window = UIApplication.shared.delegate?.window!
        let hideRect = displayRect.offsetBy(dx: 0, dy: window!.frame.height)
        let newDisplayRect = hideRect.offsetBy(dx: 0, dy: 124)
        let destinationView = self.destination.view as UIView!
        
        //set the destination View center
        destinationView?.frame = hideRect
        
        // the Views must be in the Window hierarchy, so insert as a subview the destionation above the source
        window?.insertSubview(destinationView!, aboveSubview: sourceView!)
        
        //create UIAnimation- change the views's position when present it
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [.allowUserInteraction, .curveEaseInOut], animations: {
            destinationView?.frame = newDisplayRect
        }, completion: { (isSuccess) in
            self.source.navigationController?.pushViewController(self.destination, animated: false)
        })
    }
}

