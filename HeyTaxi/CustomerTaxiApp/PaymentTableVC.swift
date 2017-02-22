//
//  PaymentMTableVC.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/8/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit

class PaymentTableVC: UITableViewController {
    weak var sideMenuVC: SideMenuTableVC!
    let paymentHelper = PaymentHelper()
    let cellHeight :CGFloat = 50
    var payments : [Payment] = [] {
        didSet {
            guard payments.count != oldValue.count else {
                return
            }
            sideMenuVC.paymentTableVC(paymentTableVC: self, setContainerHeight: CGFloat(payments.count) * cellHeight)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        payments = paymentHelper.payments
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sideMenuVC.paymentTableVC(paymentTableVC: self, setContainerHeight: tableView.contentSize.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return payments.count + 1
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {return }
        if cell is AddMorePaymentTableCell {
            sideMenuVC.containerVC.performSegue(withIdentifier: SegueIdentifier.showAddPayment, sender: nil)
        } else if cell is PaymentCell {
            cell.accessoryType = .checkmark
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {return }
        if cell is PaymentCell {
            cell.accessoryType = .none
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == payments.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.addMorePaymentTableCell, for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.paymentCell, for: indexPath)
            cell.textLabel?.text = payments[indexPath.row].name
            return cell
        }
    }

}
