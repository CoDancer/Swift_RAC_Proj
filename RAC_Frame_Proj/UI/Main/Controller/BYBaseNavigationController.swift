//
//  BYBaseNavigationController.swift
//  RAC_Frame_Proj
//
//  Created by CoDancer on 2018/7/22.
//  Copyright © 2018年 IOS. All rights reserved.
//

import UIKit

class BaseNavigation: UINavigationController, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.openFullScreenGes()
    }
    
    func openFullScreenGes() -> Void {
        
        let target = self.interactivePopGestureRecognizer?.delegate
        let handler = NSSelectorFromString("handleNavigationTransition:")
        
        let targetView = self.interactivePopGestureRecognizer?.view
        
        let fullScreenGes = UIPanGestureRecognizer.init(target: target, action: handler)
        fullScreenGes.delegate = self
        targetView?.addGestureRecognizer(fullScreenGes)
        
        self.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if self.childViewControllers.count == 1 {
            return false
        }else {
            return true
        }
        
    }
    
}
