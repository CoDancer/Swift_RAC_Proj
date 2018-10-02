//
//  UIImage+.swift
//  RAC_Frame_Proj
//
//  Created by CoDancer on 2018/8/9.
//  Copyright © 2018年 IOS. All rights reserved.
//

import UIKit

 extension UIImage {
    
    class func imageWithRect(rect: CGRect, color: UIColor) -> UIImage {
        
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }

}
