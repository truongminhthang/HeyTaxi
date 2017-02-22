//
//  BasePageVC.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/11/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import Foundation


import UIKit

class BasePageVC: UIPageViewController, UIPageViewControllerDelegate {
    
    var currentViewController: UIViewController? {
        return viewControllers?[0]
    }
    var index : Int {
        guard currentViewController != nil else {
            return NSNotFound
        }
        return modelController.indexOfViewController(currentViewController!)
    }
    private var _scrollView: UIScrollView? = nil
    var scrollView: UIScrollView! {
        if _scrollView == nil {
            for view in self.view.subviews {
                if(view is UIScrollView) {
                    _scrollView = (view as! UIScrollView)
                }
            }
        }
        
        return _scrollView
    }
    
    var startViewControllerIndex : Int {
        return 0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Configure the page view controller and add it as a child view controller.
        delegate = self
        dataSource = modelController
        if let startingViewController: UIViewController = self.modelController.viewControllerAtIndex(startViewControllerIndex) {
            
            let viewControllers = [startingViewController]
            setViewControllers(viewControllers, direction: .forward, animated: false, completion: {done in })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var modelController: BaseModelController! {
        // Return the model controller object, creating it if necessary.
        // In more complex implementations, the model controller may be passed to the view controller.
      
        return nil
    }
    
    var _modelController: BaseModelController? = nil
    
    // MARK: - UIPageViewController delegate methods
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
    }
    
    func next() {
        jump(toIndex: index + 1)
    }
    
    func previous() {
        jump(toIndex: index - 1)
    }
    
    func jump(toIndex: Int, animated: Bool = true) {
        guard toIndex != NSNotFound && toIndex >= 0 else {
            return
        }
        let direction : UIPageViewControllerNavigationDirection = toIndex > index ? .forward : .reverse
        if let viewController = modelController.viewControllerAtIndex(toIndex) {
            self.setViewControllers([viewController], direction: direction , animated: true, completion: {done in })
        }
    }
    
    func jumpToOrderTaxi() {
        jump(toIndex: 1, animated: false)
    }
    
}



