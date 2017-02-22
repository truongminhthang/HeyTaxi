//
//  UserInfoTableVC.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/10/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit

enum UserInfoTableCellType: Int {
    case avatar
    case fullName
    case phoneNumber
    case gmail
    case connectFacebook
    case connectGoogle
    case favorite
    case subFavorite
    case userFile
    case subUserFile
    
    var indexCell: IndexPath {
        return IndexPath(row: self.rawValue, section: 0)
    }
}

class UserInfoTableVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - TableViewDelegate
extension UserInfoTableVC {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cellType = UserInfoTableCellType.init(rawValue: indexPath.row) else { return 0 }
        switch cellType {
        case .avatar:
            return 150
        default:
            return 50
        }
    }
}




