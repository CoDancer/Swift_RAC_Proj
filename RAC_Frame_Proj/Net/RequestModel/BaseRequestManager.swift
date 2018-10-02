//
//  BaseRequestManager.swift
//  RAC_Frame_Proj
//
//  Created by CoDancer on 2018/7/22.
//  Copyright © 2018年 IOS. All rights reserved.
//

import UIKit
import Alamofire

class BaseRequestModel: NSObject {
    
    var accessToken: String!
    var tutuUid : String!
    var lang : String!
    var devicetype : String!
    
    var identifier : String!
    
    override init() {
        
        super.init()
        tutuUid = ""
        accessToken = ""
        lang = "zh-cn"
        devicetype = "phone"
        identifier = KeychainIDFA.deviceID()
    }
}

class BaseRequestManager: NSObject {
    
    /**
     服务器数据请求:Get方式
     *
     * parameter url:    URL地址
     * parameter block:  返回结果集
     */
    static func doPostRequest(_ param: [String: String], URL: String, completeBlock: @escaping (_ response: DataResponse<Any>) -> Void) {
        
        let URLStr = "https://testyizheapi.tutuapp.com/v1/ios/home/index?accessToken=&devicetype=phone&identifier=304ca7ed-0a6a-4413-a543-9d189a599632&lang=zh-cn&page=1&pageCount=30&sign=f7d7143155435598e42f780582d194f3&stamp=1538470780&tutuUid="
        
        Alamofire.request(URLStr, method: .get, parameters: Dictionary(), encoding: URLEncoding.default).responseJSON { response in
            
            if response.result.error == nil {
                
                /**
                 *  请求成功
                 */
                let text: NSString = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)! as NSString
                print("Data\(text as AnyObject)")
            } else {
                
                /**
                 请求出错了
                 
                 - print: 错误信息
                 */
                print("error\((response.result.error)! as AnyObject)")
            }
            
            completeBlock(response)
        }
        
    }
    
}
