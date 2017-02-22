//
//  ViewController.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/6/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit

class ContainerVC: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var leftConstraintOfSideMenu: NSLayoutConstraint!
    @IBOutlet weak var buttonCorver : UIButton!

    var sideMenuVC  : SideMenuTableVC!
    var segueIdentifier: String?
    var needToPerformSegue: Bool {
        return segueIdentifier != nil
    }
    
    
    // MARK: - Observer properties
    
    var isOpenMenu : Bool = false {
        didSet {
            if isOpenMenu {
                sideMenuView.isHidden = false
                buttonCorver.isHidden = false
                UIView.animate(withDuration: 0.35, animations: {
                    self.configOpenMenuState()
                    self.view.layoutIfNeeded()
                }, completion: { (isSuccess) in
                    
                })
            } else {
                UIView.animate(withDuration: 0.35, animations: {
                    self.configCloseMenuState()
                    self.view.layoutIfNeeded()
                }, completion: { (isSuccess) in
                    self.sideMenuView.isHidden = true
                    self.buttonCorver.isHidden = !self.needToPerformSegue
                    self.closeSideMenuDidFinish()
                })
            }
        }
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        registerNotification()
        isOpenMenu = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        segueIdentifier = nil
        hideButtonCorver()
    }
    
    deinit {
        unregisterNotification()
    }
    
    func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.toggleMenu), name: .toggleMenuDidTap, object: nil)
    }
    
    func unregisterNotification() {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case SegueIdentifier.embedSideMenu:
            sideMenuVC = segue.destination as! SideMenuTableVC
            sideMenuVC.containerVC = self
        case SegueIdentifier.popupAddPromotion:
            preparePromotionPopover(withSegue: segue)
        default:
            return
        }
    }
    
    func preparePromotionPopover(withSegue segue: UIStoryboardSegue) {
        let vc = segue.destination
        let pc = vc.popoverPresentationController
        pc?.sourceRect = CGRect(origin: self.view.center, size: CGSize.zero)
        pc?.delegate = self
        pc?.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    }
    
    func configView() {
        buttonCorver.backgroundColor = UIColor.black
        buttonCorver.addTarget(self, action: #selector(self.toggleMenu), for: UIControlEvents.touchDown)
        sideMenuView.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        sideMenuView.layer.shadowOffset = CGSize(width: 10, height: 0)
        sideMenuView.layer.shadowOpacity = 1;
    }
    
    func configOpenMenuState() {
        leftConstraintOfSideMenu.constant = 0
        buttonCorver.alpha = 0.2
    }
    
    func configCloseMenuState() {
        leftConstraintOfSideMenu.constant = -sideMenuView.frame.width
        buttonCorver.alpha = needToPerformSegue ? 0.8 : 0

    }
    
    // MARK: - ACTION 
    
    func toggleMenu() {
        isOpenMenu = !isOpenMenu
    }
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        if identifier.contains("popup") {
            super.performSegue(withIdentifier: identifier, sender: sender)
        } else {
            segueIdentifier = identifier
            toggleMenu()
        }
    }
    
    func closeSideMenuDidFinish() {
        if needToPerformSegue {
            super.performSegue(withIdentifier: segueIdentifier!, sender: nil)
        }
    }
    
    @IBAction func unwindFromAddPaymentToContainer(for unwindSegue: UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindCancle(for unwindSegue: UIStoryboardSegue) {
        
    }
    
    func hideButtonCorver() {
        buttonCorver.isHidden = true
        buttonCorver.alpha = 0
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }


}

