//
//  TranformableNAV.swift
//  HeyTaxi
//
//  Created by Trương Thắng on 2/22/17.
//  Copyright © 2017 Trương Thắng. All rights reserved.
//

import UIKit

enum DisplayState: Int {
    case full
    case middle
    case low
}

class TranformableNAV: UINavigationController {
    // MARK: - Properties
    var isPanGestureChanging        : Bool = false
    var fullScreenHeightConstant    : CGFloat = AppDelegate.shared.window!.bounds.height - 60
    var bottomSheetHeightConstant   : CGFloat = 120
    var cellHeight                  : CGFloat = 44
    var minVelocity                 : CGFloat = 200
    var statusBarHeight             : CGFloat = 20
    var middleHeightConstant        : CGFloat! = 320
    var containerVC: ContainerVC? {
        return parent as? ContainerVC
    }
    
    var coverAlphaMax: CGFloat = 0.5
    
    var coverAlpha : CGFloat = 0 {
        didSet {
            guard coverAlpha >= 0 && coverAlpha <= 1 else {return}
            self.containerVC?.corverView.alpha = self.coverAlpha
        }
    }
    
    var displayState: DisplayState = .middle {
        didSet {
            switch displayState {
            case .full:
                heightConstant = fullScreenHeightConstant
//                AppDelegate.shared.mapVC?.isInFullState = true
            case .middle:
                heightConstant = middleHeightConstant
                topViewController?.view?.endEditing(true)
//                AppDelegate.shared.mapVC?.isInFullState = false
            case .low:
                heightConstant = bottomSheetHeightConstant
                topViewController?.view?.endEditing(true)
//                AppDelegate.shared.mapVC?.isInFullState = false
            }
        }
    }
    
    var heightConstant: CGFloat! {
        get {
            return containerVC?.heightBottomSheetConstant
        }
        set {
            containerVC?.heightBottomSheetConstant = newValue
            setAlpha(fromConstant: newValue)
            UIView.animateKeyframes(withDuration: 0.15, delay: 0.0, options: [.allowUserInteraction, .calculationModeCubic], animations:  {[unowned self] in
                self.parent?.view.layoutIfNeeded()
            }) { (isSuccess) in
                self.isPanGestureChanging = false
            }
        }
    }
    
    func setAlpha(fromConstant constant: CGFloat) {
        guard constant >= middleHeightConstant else {
            coverAlpha = 0
            return
        }
        let totalDelta = fullScreenHeightConstant - middleHeightConstant
        let currentDelta = constant - middleHeightConstant
        coverAlpha = (currentDelta / totalDelta) * coverAlphaMax
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        heightConstant = middleHeightConstant

    }
    
    func setTopConstraint(velocityY: CGFloat) {
        switch heightConstant {
        case (fullScreenHeightConstant + middleHeightConstant) * 0.5 ..< fullScreenHeightConstant:
            displayState = velocityY > minVelocity ? .middle : .full
        case middleHeightConstant ..< (fullScreenHeightConstant + middleHeightConstant) * 0.5:
            displayState = velocityY < -minVelocity ? .full : .middle
        case (middleHeightConstant + bottomSheetHeightConstant) * 0.5 ..< middleHeightConstant:
            displayState = velocityY > minVelocity ? .low : .middle
        case bottomSheetHeightConstant ..< (middleHeightConstant + bottomSheetHeightConstant) * 0.5 :
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
        guard heightConstant != nil else {   return }
        let newHeightConstant = heightConstant - deltaY.y
        
        if newHeightConstant < fullScreenHeightConstant && newHeightConstant > bottomSheetHeightConstant {
            heightConstant = newHeightConstant
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
        if ( heightConstant >= fullScreenHeightConstant && fabs(tableView.contentOffset.y) < 20 && direction > 0) ||  (heightConstant <= middleHeightConstant) {
            tableView.isScrollEnabled = false
        } else {
            tableView.isScrollEnabled = true
        }
    }

}
