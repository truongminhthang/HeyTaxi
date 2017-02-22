//
//  NavigationController.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/24/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

enum DisplayState: Int {
    case full
    case middle
    case low
}


class TransformNavigationController: UINavigationController {
    
    // MARK: - Properties
    var isPanGestureChanging        : Bool = false
    var fullScreenTopConstant       : CGFloat = 80
    var bottomSheetTopConstant      : CGFloat = 80
    var cellHeight                  : CGFloat = 44
    var minVelocity                 : CGFloat = 200
    var statusBarHeight             : CGFloat = 20

    var middleTopConstant: CGFloat! {
        return (fullScreenTopConstant + bottomSheetTopConstant) * 0.5 + 60
    }
    
    var mapContainerVC: MapContainerVC? {
        return parent as? MapContainerVC
    }
    
    var mapVC: MapVC? {
        return AppDelegate.share.mapVC
    }
    
    var mapView: GMSMapView? {
        return AppDelegate.share.mapVC?.mapView
    }
    
    var displayState: DisplayState = .middle {
        didSet {
            switch displayState {
            case .full:
                topConstant = fullScreenTopConstant
            case .middle:
                topConstant = middleTopConstant
                topViewController?.view?.endEditing(true)
            case .low:
                topConstant = bottomSheetTopConstant
                topViewController?.view?.endEditing(true)
            }
        }
    }
    
    var topConstant: CGFloat! {
        get {
            return mapContainerVC?.topBottomSheetConstant
        }
        set {
            mapContainerVC?.topBottomSheetConstant = newValue
            UIView.animate(withDuration: 0.15, delay: 0.0, options: [.allowUserInteraction, .curveEaseInOut], animations: {
                self.parent?.view.layoutIfNeeded()
            }, completion: { (isSuccess) in
                self.isPanGestureChanging = false
                NotificationCenter.default.post(name: .displayingModeDidChange, object: nil)

            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomSheetTopConstant = view.frame.height - 144
        viewControllers =  [RouteManagementVC.instance, SearchPlaceVC.instance]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        topConstant = middleTopConstant
    }

    func setTopConstraint(velocityY: CGFloat) {
        switch topConstant {
        case fullScreenTopConstant ..< (fullScreenTopConstant + middleTopConstant) * 0.5:
            displayState = velocityY > minVelocity ? .middle : .full
        case (fullScreenTopConstant + middleTopConstant) * 0.5 ..< middleTopConstant:
            displayState = velocityY < -minVelocity ? .full : .middle
        case middleTopConstant ..< (middleTopConstant + bottomSheetTopConstant) * 0.5 :
            displayState = velocityY > minVelocity ? .low : .middle
        case (middleTopConstant + bottomSheetTopConstant) * 0.5 ..< bottomSheetTopConstant:
            displayState = velocityY < -minVelocity ? .middle : .low
        default:
            return
        }
    }
    
    func handlePanGesture(sender: UIPanGestureRecognizer, tableView: UITableView?) {
        let deltaY = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        tableView?.allowsSelection = false
        if fabs(velocity.y) > 100 {
            self.view.endEditing(true)
        }
        guard topConstant != nil else {   return }
        let newTopConstant = topConstant + deltaY.y
        if newTopConstant > fullScreenTopConstant && newTopConstant < bottomSheetTopConstant {
            topConstant = newTopConstant
            sender.setTranslation(CGPoint.zero, in: view)
        }
        
        if sender.state == .ended {
            guard isPanGestureChanging == false else {
                return
            }
            isPanGestureChanging = true
            setTopConstraint(velocityY: velocity.y)
            tableView?.allowsSelection = true
        }
    }
    
    func disableTableViewScrollIfNeed(tableView: UITableView, gestureRecognizer: UIGestureRecognizer) {
        let gesture = (gestureRecognizer as! UIPanGestureRecognizer)
        let direction = gesture.velocity(in: view).y
        if ( topConstant <= fullScreenTopConstant && fabs(tableView.contentOffset.y) < 20 && direction > 0) ||  (topConstant >= middleTopConstant) {
            tableView.isScrollEnabled = false
        } else {
            tableView.isScrollEnabled = true
        }
    }
    
    
}
