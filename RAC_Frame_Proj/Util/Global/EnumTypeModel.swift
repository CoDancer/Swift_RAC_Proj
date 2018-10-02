//
//  EnumTypeModel.swift
//  RAC_Frame_Proj
//
//  Created by CoDancer on 2018/8/8.
//  Copyright © 2018年 IOS. All rights reserved.
//

import UIKit

enum RequestResultType {
    
    case RequestSuccessful
    case RequestFail
    case RequestNetError
    case RequestTokenIsInvalid  //token 无效
}

enum VC_type {   //控制器的类型
    
    case topVC_type
    case navi_type
    case presetVC_type
}
