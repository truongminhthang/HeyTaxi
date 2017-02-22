//
//  SideMenuTVC.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/6/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit


enum SideMenuCellType : Int {
    case avatar
    case payment
    case subPayment
    case promote
    case tripHistory
    case userInfo
    case support
    case cooperation
    
    var index: IndexPath {
        return IndexPath(row: self.rawValue, section: 0)
    }
}

class SideMenuTableVC: UITableViewController {
    
    @IBOutlet weak var paymentContainerView: UIView!
    weak var containerVC : ContainerVC!
    
    var paymentTableVC: PaymentTableVC!
    var subPaymentCellHeight: CGFloat = 0
    
    // MARK: Observer Properties
    
    var subPaymentActiveCellHight: CGFloat = 100 {
        didSet {
            tableView.reloadRows(at: [SideMenuCellType.subPayment.index], with: .none)
        }
    }
    
    var subPaymentActive : Bool = false {
        didSet {
            subPaymentCellHeight = subPaymentActive ?  subPaymentActiveCellHight : 0
            
            tableView.reloadRows(at: [SideMenuCellType.subPayment.index], with: subPaymentActive ?.bottom : .top)
        }
    }
    
    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configOriginState()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configOriginState() {
        subPaymentActive = false
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case SegueIdentifier.embedPaymentTableVC:
            paymentTableVC = segue.destination as! PaymentTableVC
            paymentTableVC.sideMenuVC = self
        default:
            return
        }
    }
}

// MARK: - TableViewDelegate

extension SideMenuTableVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cellType = SideMenuCellType.init(rawValue: indexPath.row) else {
            return
        }
        switch cellType {
        case .payment :
            subPaymentActive = !subPaymentActive
        case .tripHistory:
            containerVC.performSegue(withIdentifier: SegueIdentifier.showTripHistories, sender: nil)
        case .promote:
            containerVC.performSegue(withIdentifier: SegueIdentifier.popupAddPromotion, sender: nil)
        case .userInfo:
            containerVC.performSegue(withIdentifier: SegueIdentifier.showUserInfo, sender: nil)
        case .support:
            containerVC.performSegue(withIdentifier: SegueIdentifier.showSupportVC, sender: nil)
        case .cooperation:
            containerVC.performSegue(withIdentifier: SegueIdentifier.showBecomeCooperationVC, sender: nil)
        default:
            return
        }
    }
    
}

// MARK: - TableViewDataSource

extension SideMenuTableVC {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cellType = SideMenuCellType.init(rawValue: indexPath.row) else {
            return 0
        }
        switch cellType {
        case .subPayment:
            return subPaymentCellHeight
        case .avatar:
            return 200
        default:
            return 50.0
        }
        
    }
}

// MARK: - paymentTableVC

extension SideMenuTableVC {
    func paymentTableVC (paymentTableVC: PaymentTableVC, setContainerHeight height: CGFloat) {
        subPaymentActiveCellHight = height
    }
}
