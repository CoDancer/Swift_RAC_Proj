//
//  UserRealmModel.swift
//  RAC_Frame_Proj
//
//  Created by CoDancer on 2018/8/11.
//  Copyright © 2018年 IOS. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class UserRealmModel: NSObject {
    
    @objc dynamic var tutuId = ""
    @objc dynamic var tutuName = ""
    @objc dynamic var userToken = ""
    @objc dynamic var isVip = false
    
    var languageArr = List<String>()
    let shareWayArr = List<String>()
    
    func writeData(userModel: UserModel) {
        
        let user = UserRealmModel()
        user.tutuId = userModel.tutuId!
        user.tutuName = userModel.tutuName!
        
        for obj in userModel.languageArr! {
            user.languageArr.append(obj)
        }
        
    }
}
