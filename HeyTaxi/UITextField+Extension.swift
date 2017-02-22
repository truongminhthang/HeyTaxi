//
//  UITextField+Extension.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 2/22/17.
//  Copyright © 2017 Trương Thắng. All rights reserved.
//

import UIKit

extension UITextField{
    @IBInspectable var placeHolderTextColor: UIColor? {
        set {
            let placeholderText = self.placeholder != nil ? self.placeholder! : ""
            attributedPlaceholder = NSAttributedString(string:placeholderText, attributes:[NSForegroundColorAttributeName: newValue!])
        }
        get{
            return self.placeHolderTextColor
        }
    }
}
