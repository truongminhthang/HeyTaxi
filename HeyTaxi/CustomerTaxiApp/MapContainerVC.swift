//
//  MapContainerVC.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/14/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit

enum MenuType: Int {
    case quickSelect
    case orderTaxi
    case confirmPlace
}

class MapContainerVC: UIViewController {
    
    @IBOutlet weak var confirmDestinateButton: UIButton!
    @IBOutlet weak var topBottomSheetConstraint: NSLayoutConstraint!
    var topBottomSheetConstant : CGFloat! {
        didSet {
            topBottomSheetConstraint.constant = topBottomSheetConstant
        }
    }
    
    // MARK: - LIFE CYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case SegueIdentifier.embedMapVC:
            AppDelegate.share.mapVC = segue.destination as? MapVC
            AppDelegate.share.mapVC?.mapContainer = self
        default:
            return
        }
    }

    // MARK: - ACTION
    
    @IBAction func menuDidTap(_ sender: Any) {
        NotificationCenter.default.post(name: .toggleMenuDidTap, object: nil)

    }
    
    @IBAction func destinationMarkerDidTap() {
        NotificationCenter.default.post(name: .destinationMarkerDidTap, object: nil)
    }
}
