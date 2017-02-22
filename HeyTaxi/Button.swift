//
//  RoundedCornerButton.swift
//  HeyTaxi
//
//  Created by Trương Thắng on 2/22/17.
//  Copyright © 2017 Trương Thắng. All rights reserved.
//

import UIKit


@IBDesignable
class Button: UIButton {
    @IBInspectable
    var disableColor : UIColor = UIColor.darkGray {
        didSet {
            self.setBackgroundImage(UIImage(color: disableColor), for: .disabled)
        }
    }
    
    @IBInspectable
    var enableColor : UIColor  = UIColor.white {
        didSet {
            self.setBackgroundImage(UIImage(color: enableColor), for: .normal)
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat = -1 {
        didSet {
            guard cornerRadius >= -1 else {return}
            if cornerRadius == -1 {
                self.layer.cornerRadius = bounds.height * 0.5
            } else {
                self.layer.cornerRadius = cornerRadius
            }
        }
    }
}



public extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
