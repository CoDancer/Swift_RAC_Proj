//
//  Sting+.swift
//  RAC_Frame_Proj
//
//  Created by CoDancer on 2018/8/8.
//  Copyright © 2018年 IOS. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    var md5 : String{
        
        let cStr = self.cString(using: String.Encoding.utf8);
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(cStr!,(CC_LONG)(strlen(cStr!)), buffer)
        let md5String = NSMutableString();
        for i in 0 ..< CC_MD5_DIGEST_LENGTH{
            md5String.appendFormat("%02x", buffer[Int(i)])
        }
        free(buffer)
        return md5String as String
    }

}
