//
//  String+Extension.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/27/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import Foundation

// MARK: - <#Mark#>

extension String {
    var asciiString: String? {
        if let data = self.data(using: String.Encoding.ascii, allowLossyConversion: true){
            return String.init(data: data, encoding: String.Encoding.ascii)
        }
        return nil
    }
}
//
//extension String {
//    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
//        let constraintRect = CGSize(width: width, height: CGFloat.max)
//        let boundingBox = self.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
//        return boundingBox.height
//    }
//}
