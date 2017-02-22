//
//  BaseBottomMenuVC.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/24/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit

class BaseBottomMenuVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    unowned var transformNAV: TransformNavigationController = TransformNavigationController()
    weak var mapVC: MapVC?
    var topConstant: CGFloat! {
        set {
            transformNAV.topConstant = newValue
        }
        get {
            return transformNAV.topConstant
        }
    }
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNotification()
        if let transformNAV = (navigationController as? TransformNavigationController) {
            self.transformNAV = transformNAV
            mapVC = transformNAV.mapVC
        }
        

    }
    
    func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(navigationControllerDidChangeDisplayingMode), name: .displayingModeDidChange, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func navigationControllerDidChangeDisplayingMode() {
        
    }
    
    
    
}


// MARK: - SearchPlaceVC handle PanGesture

extension BaseBottomMenuVC {
    
    @IBAction func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        guard isEditing != true    else {return}
        transformNAV.handlePanGesture(sender: sender, tableView: tableView)
    }
}

extension BaseBottomMenuVC: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {

        transformNAV.disableTableViewScrollIfNeed(tableView: tableView, gestureRecognizer: gestureRecognizer)
        return false
    }
}
