//
//  BYMainViewService.swift
//  RAC_Frame_Proj
//
//  Created by CoDancer on 2018/7/29.
//  Copyright © 2018年 IOS. All rights reserved.
//

import UIKit
import Result
import ReactiveCocoa
import ReactiveSwift
import ObjectMapper
import SwiftyJSON

class BYHomeRequest: NSObject {
    
    class func homeDataRequest(page: Int) -> SignalProducer<HomeModel, NoError> {
        
        return SignalProducer<HomeModel, NoError>.init { (observer, _) in
            
            var params = [String : String]()
            params["page"] = "1"
            params["pageCount"] = "30"
            BaseRequestManager.doPostRequest(params,
                                             URL:RequestUrl.HOME_URL) { (response) -> Void in
                                                
                                                if response.result.error == nil {
                                                
                                                    let responseModel = Mapper<HomeModel>().map(JSONObject: response.result.value)
                                                    observer.send(value: responseModel!)
                                                    
                                                }else {
                                                    //网络出错
                                                    let responseModel = HomeModel()
                                                    responseModel.netErrorResultModel()
                                                    observer.send(value: responseModel)
                                                }
            }
            
        }
    }
    

}
