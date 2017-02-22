//
//  PaymentHelper.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/8/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import Foundation

class PaymentHelper {
    var payments: [Payment] = {
        return [Payment(name: "Tiền mặt", securityCode: nil),
                Payment(name: "ATM", securityCode: nil),
                Payment(name: "Visa", securityCode: nil),
        ]
    }()
    
}
