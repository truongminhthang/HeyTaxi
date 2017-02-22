//
//  BaseCollectionMenuVC.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/14/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit

class CollectionViewDelegateFlowLayout: NSObject, UICollectionViewDelegateFlowLayout {
    let kMinInteritemSpacing    : CGFloat = 0
    let kMinimumLineSpacing     : CGFloat = 0
    let kEdgeInset              = UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 0)
    var numberOfItemInRow       : CGFloat {
        return 3.5
    }
    var itemHeight: CGFloat      = 50
    var _itemSize               : CGSize?
    var itemSize                : CGSize  {
        if _itemSize == nil {
            
            let width = UIScreen.main.bounds.width
            let itemWidth = (width - kEdgeInset.left - kEdgeInset.right - (numberOfItemInRow - 1) * kMinInteritemSpacing ) / numberOfItemInRow
            _itemSize = CGSize(width: itemWidth, height: itemHeight)
        }
        return _itemSize!
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return kEdgeInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return kMinInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return kMinimumLineSpacing
    }
}
