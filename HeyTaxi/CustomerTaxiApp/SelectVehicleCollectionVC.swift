//
//  SelectVehicleCollectionVC.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/19/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit

enum CarType: Int {
    case normalCar
    case largeCar
    case airportCar
    
    var image: UIImage {
        switch self {
        case .normalCar:
            return #imageLiteral(resourceName: "i10")
        case .largeCar:
            return #imageLiteral(resourceName: "innova")
        case .airportCar:
            return #imageLiteral(resourceName: "NormalCar")
        }
    }
    
    var name: String {
        switch self {
        case .normalCar:
            return "Taxi 4 chỗ"
        case .largeCar:
            return "Taxi 7 chỗ"
        case .airportCar:
            return "Taxi sân bay"
        }
    }

}

class SelectVehicleCollectionVC: UICollectionViewController {
    var collectionViewFlowLayout :CollectionViewFlowLayout!
    var carTypes : [CarType] = [.normalCar, .largeCar,. airportCar]
    
    // MARK: LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let itemSize = CGSize(width: 300, height: 180)
        collectionViewFlowLayout = CollectionViewFlowLayout.layoutConfigured(with: self.collectionView!, itemSize: itemSize, minimumLineSpacing: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
   
}

//MARK: UICollectionViewDataSource

extension SelectVehicleCollectionVC {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carTypes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.selectVehicleCell, for: indexPath ) as! SelectVehicleCell
        configureCell(cell: cell, forItemAt: indexPath)
        return cell
    }
    
    func configureCell(cell: SelectVehicleCell, forItemAt indexPath: IndexPath) {
        let carType = carTypes[indexPath.item]
        cell.imageView.image = carType.image
        cell.carTypeLabel.text = carType.name
        cell.priceLabel.text = "1.000.000 đ"
    }
    
    
}



