//
//  BaseTranfromableVC.swift
//  HeyTaxi
//
//  Created by Trương Thắng on 2/22/17.
//  Copyright © 2017 Trương Thắng. All rights reserved.
//

import Foundation


import UIKit

class BaseTranformableVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    weak var mapVC: MapVC?
    var topConstant: CGFloat! {
        set {
            AppDelegate.shared.tranformableNav?.heightConstant = newValue
        }
        get {
            return AppDelegate.shared.tranformableNav?.heightConstant
        }
    }
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

// MARK: - SearchPlaceVC handle PanGesture

extension BaseTranformableVC {
    
    @IBAction func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        guard isEditing != true    else {return}
        AppDelegate.shared.tranformableNav?.handlePanGesture(sender: sender, tableView: tableView)
    }
}

extension BaseTranformableVC: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        AppDelegate.shared.tranformableNav?.disableTableViewScrollIfNeed(tableView: tableView, gestureRecognizer: gestureRecognizer)
        return false
    }
}
