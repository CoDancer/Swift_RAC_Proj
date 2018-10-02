//
//  BaseResultModel.swift
//  RAC_Frame_Proj
//
//  Created by CoDancer on 2018/8/8.
//  Copyright © 2018年 IOS. All rights reserved.
//  所有的网络得到后model必须继承该Model

import UIKit
import Alamofire
import ObjectMapper
import Result

class BaseResultModel: Mappable {
    
    var requestType: RequestResultType?
    var msg : String = ""
    
    init(){}
    required init?(map: Map){}
    
    func mapping(map: Map) {
        
        var stautsDic = [String: Any]()
        stautsDic <- map["status"]
        let codeStatus: NSNumber = stautsDic["code"] as! NSNumber
        msg = stautsDic["message"] as! String
        
        if codeStatus == 0 {
            requestType = .RequestSuccessful
        }else if codeStatus == 301 {
            requestType = .RequestTokenIsInvalid
        }else {
            requestType = .RequestFail
        }
    }
    
    func netErrorResultModel() {
        
        requestType = RequestResultType.RequestNetError
        msg = "网络请求超时"
    }
}
