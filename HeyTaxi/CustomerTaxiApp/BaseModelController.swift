//
//  BaseModelController.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/11/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit

class BaseModelController: NSObject, UIPageViewControllerDataSource {
    
    var viewcontrollers: [UIViewController]
    
    init(with viewcontrollers: [UIViewController]) {
        self.viewcontrollers = viewcontrollers
    }
    
    func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        // Return the data view controller for the given index.
        if (self.viewcontrollers.count == 0) || (index >= self.viewcontrollers.count) || (index < 0) {
            return nil
        }
        return viewcontrollers[index]
    }
    
    func indexOfViewController(_ viewController: UIViewController) -> Int {
        var result : Int = NSNotFound
        for (index, element) in viewcontrollers.enumerated() {
            if element === viewController {
                result = index
            }
        }
        return result
    }
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController)
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        if index == self.viewcontrollers.count {
            return nil
        }
        return self.viewControllerAtIndex(index)
    }
}

