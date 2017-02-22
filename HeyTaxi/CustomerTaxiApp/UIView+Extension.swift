//
//  UIView+Extension.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 1/2/17.
//  Copyright © 2017 Trương Thắng. All rights reserved.
//

import UIKit

// MARK: - UIView
enum PinPosition : Int {
    case HighLeft, HighCenter, HighRight
    case MidLeft, MidRight
    case LowLeft, LowCenter, LowRight
}

extension UIView {
    func pin(to parentsView: UIView, atPosition pinPosition: PinPosition, size: CGSize) {
        switch pinPosition {
        case .LowCenter:
            parentsView.addSubview(self)
            parentsView.translatesAutoresizingMaskIntoConstraints = false
            self.translatesAutoresizingMaskIntoConstraints = false
            let views = ["self": self]
            let horizontalFormat = "|[self]|"
            let verticalFormat = "V:[self(==80)]|"
            let constraints = NSLayoutConstraint.constraints(withVisualFormat: horizontalFormat, options:.alignAllTop , metrics: nil, views: views)
            let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: verticalFormat, options:.alignAllTop , metrics: nil, views: views)
            
            NSLayoutConstraint.activate(constraints)
            NSLayoutConstraint.activate(vConstraints)

        default:
            return
        }
    }
    
    
}
