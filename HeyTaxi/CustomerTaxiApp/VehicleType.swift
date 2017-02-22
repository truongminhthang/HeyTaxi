//
//  VehicleModel.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/6/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import Foundation

enum VehicleType {
    case normalCar
    case largeCar
    case planCar
    
    var title: String {
        switch self {
        case .normalCar:
            return "Xe 4 chỗ"
        case .largeCar:
            return "Xe 7 chỗ"
        case .planCar:
            return "Xe Sân bay"
        
        }
    }
}
