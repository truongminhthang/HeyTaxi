////
////  SelectVehicleCollectionVC.swift
////  CustomerTaxiApp
////
////  Created by Trương Thắng on 12/19/16.
////  Copyright © 2016 Trương Thắng. All rights reserved.
////
//
//import UIKit
//
//class SelectVehicleCollectionVC: UICollectionViewController {
//    var collectionViewFlowLayout :CollectionViewFlowLayout!
//    var carTypes = VehicleServices.shared.vehicles
//    
//    // MARK: LIFE CYCLE
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let itemSize = CGSize(width: 300, height: 180)
//        collectionViewFlowLayout = CollectionViewFlowLayout.layoutConfigured(with: self.collectionView!, itemSize: itemSize, minimumLineSpacing: 0)
//    }
//}
//
////MARK: UICollectionViewDataSource
//
//extension SelectVehicleCollectionVC {
//    
//    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return carTypes.count
//    }
//    
//    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CellID.selectVehicleCell, forIndexPath: indexPath) as! SelectVehicleCell
//        configureCell(cell, forItemAt: indexPath)
//        return cell
//    }
//    
//    func configureCell(cell: SelectVehicleCell, forItemAt indexPath: NSIndexPath) {
//        let carType = carTypes[indexPath.item]
//        if let data = NSData(base64EncodedString: carType.imageBase64, options: NSDataBase64DecodingOptions(rawValue: 0)) {
//            
//            cell.imageView.image = UIImage(data: data)
//        } else {
//            cell.imageView.image = UIImage(named: "i10")
//        }
//        cell.carTypeLabel.text = carType.name
//        cell.priceLabel.text = currencyStringFrom(carType.getFreight(from: 5))
//    }
//    
//    func currencyStringFrom(number: Double) -> String {
//        let currencyFormatter = NSNumberFormatter()
//        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyISOCodeStyle
//        currencyFormatter.locale = NSLocale(localeIdentifier: "FR")
//        currencyFormatter.currencyCode = "VND"
//        currencyFormatter.currencyGroupingSeparator = "."
//        return currencyFormatter.stringFromNumber(number) ?? ""
//    }
//    
//    
//}
//
//
//
