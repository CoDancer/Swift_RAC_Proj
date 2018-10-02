//
//  BYHomeViewModel.swift
//  RAC_Frame_Proj
//
//  Created by CoDancer on 2018/8/8.
//  Copyright © 2018年 IOS. All rights reserved.
//

import UIKit
import Result
import ReactiveCocoa
import ReactiveSwift

class BYHomeViewModel: NSObject {
    
    var action : Action<(), HomeModel, NoError>!   //获取界面数据的事件
    
    func getHomeDataRequest(page: Int, completion completed: ((_ model: HomeModel) -> Swift.Void)? = nil) {
        
        action = Action<(), HomeModel, NoError> { (_) -> SignalProducer<HomeModel, NoError> in
            
            BYHomeRequest.homeDataRequest(page: page)
        }
        
        action.apply(()).start { (event) in
            
            if completed != nil {
                completed!(event.value!)
            }
        }
    }

}
