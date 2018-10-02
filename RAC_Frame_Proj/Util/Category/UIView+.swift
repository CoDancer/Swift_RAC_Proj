//
//  String.swift
//  V2EX
//
//  Created by darker on 2017/3/23.
//  Copyright © 2017年 darker. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    var x : CGFloat {
        
        get {
            
            return frame.origin.x
        }
        
        set(newVal) {
            
            var tmpFrame : CGRect = frame
            tmpFrame.origin.x     = newVal
            frame                 = tmpFrame
        }
    }
    
    // y
    var y : CGFloat {
        
        get {
            
            return frame.origin.y
        }
        
        set(newVal) {
            
            var tmpFrame : CGRect = frame
            tmpFrame.origin.y     = newVal
            frame                 = tmpFrame
        }
    }
    
    var size : CGSize {
        
        set(newVal) {
            var tmpFrame : CGRect = frame
            tmpFrame.size  = newVal
            frame     = tmpFrame
        }
        get {
            return frame.size
        }
    }
    
    var width : CGFloat {
        
        get {
            return frame.size.width
        }
        
        set(newVal) {
            var tmpFrame : CGRect = frame
            tmpFrame.size.width   = newVal
            frame                 = tmpFrame
        }
    }
    
    var height : CGFloat {
        
        get {
            return frame.size.height
        }
        
        set(newVal) {
            var tmpFrame : CGRect = frame
            tmpFrame.size.height  = newVal
            frame                 = tmpFrame
        }
    }
    
    var leftX : CGFloat {
        
        get {
            
            return x
        }
        
        set(newVal) {
            
            x = newVal
        }
    }
    
    var rightX : CGFloat {
        
        get {
            
            return x + width
        }
        
        set(newVal) {
            
            x = newVal - width
        }
    }
    
    var topY : CGFloat {
        
        get {
            
            return y
        }
        
        set(newVal) {
            
            y = newVal
        }
    }
    
    var bottomY : CGFloat {
        
        get {
            
            return y + height
        }
        
        set(newVal) {
            
            y = newVal - height
        }
    }
    
    var centerX : CGFloat {
        
        get {
            
            return center.x
        }
        
        set(newVal) {
            
            center = CGPoint(x: newVal, y: center.y)
        }
    }
    
    var centerY : CGFloat {
        
        get {
            
            return center.y
        }
        
        set(newVal) {
            
            center = CGPoint(x: center.x, y: newVal)
        }
    }
    
    
    func viewRotate() -> Void {
        
        let transformAnima = CABasicAnimation.init(keyPath: "transform.rotation.y")
        transformAnima.fromValue = [0]
        transformAnima.toValue = NSNumber.init(value: Double.pi)
    }
    
    func addShadowOnTop() -> Void {
        
        let shadowPath = UIBezierPath.init(rect: self.bounds)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize.init(width: 1.0, height: -2)
        self.layer.shadowOpacity = 0.1
        self.layer.shadowPath = shadowPath.cgPath
    }
    
    func addShadowOnBottom() -> Void {
        
        let shadowPath = UIBezierPath.init(rect: self.bounds)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize.init(width: 1.0, height: 2.0)
        self.layer.shadowOpacity = 0.1
        self.layer.shadowPath = shadowPath.cgPath
    }
    
}


