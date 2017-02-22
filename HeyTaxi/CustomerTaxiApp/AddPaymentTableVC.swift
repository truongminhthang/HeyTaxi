//
//  AddMorePaymentTableVC.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/9/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit

enum AddPaymentCellType : Int {
    
    case numberCard
    case expirationDate
    case cvv
    case addCountry
    
    var index: IndexPath {
        return IndexPath(row: self.rawValue, section: 0)
    }
}

class AddPaymentTableVC: UITableViewController,UIPopoverPresentationControllerDelegate {
    
    //MARK: - Properties
    @IBOutlet weak var numberCreditCardTextfield: UITextField!
    @IBOutlet weak var expirationDateTextfield: UITextField!
    @IBOutlet weak var numberCVVTextfield: UITextField!
    @IBOutlet weak var nameCountryLabel: UILabel!
    @IBOutlet weak var imageCountry: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberCreditCardTextfield.keyboardType = UIKeyboardType.numberPad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func unwindAddPaymentTableVC(for unwindSegue: UIStoryboardSegue) {
        let selectCountryVC = unwindSegue.source as! SelectCountryVC
        let indexPath = selectCountryVC.tableView.indexPathForSelectedRow ?? IndexPath(row: 0, section: 0)
        nameCountryLabel.text = selectCountryVC.arrayCountry[indexPath.row]
    }
}

extension AddPaymentTableVC {

}
