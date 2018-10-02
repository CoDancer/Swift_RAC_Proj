//
//  MainHomeViewModel.swift
//  SwiftProj
//
//  Created by CoDancer on 2017/7/3.
//  Copyright © 2017年 CoDancer. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper

class HomeModel: BaseResultModel {
    
    var dataModel : HomeDataModel?
    
    override func mapping(map: Map) {
        
        super.mapping(map: map)
        
        dataModel <- map["data"]
    }

}

class HomeDataModel: Mappable {
    
    var homeBannerModels : [HomeBannerModel]?
    var homeSelectedModels : [AppModel]?
    var homeHotModels : [AppModel]?
    var homeSpecialModels : [HomeBannerModel]?
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        
        homeBannerModels <- map["topAdList"]
        homeSpecialModels <- map["specialList"]
        homeSelectedModels <- map["selectedList"]
        homeHotModels <- map["hotList"]
    }
}

class HomeBannerModel : Mappable {

    var bannerId : NSNumber?
    var bannerType : String?
    var title: String?
    var pictureUrl : String?
    var listArea : NSNumber?
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        
        bannerId <- map["id"]
        bannerType <- map["type"]
        title <- map["title"]
        pictureUrl <- map["picture"]
        listArea <- map["listArea"]
    }
}

class AppModel : Mappable {
    
    var appId: NSNumber?
    var appName : String?
    var appIntroduction : String?
    var appIcon : String?
    
    var appCategory: String?
    var appCategoryCode : String?
    var avgScore : NSNumber?
    var appSize : String?
    
    var appVersion: String?
    var downloadUrl : String?
    var supportIpad : String?
    var supportIphone : String?
    
    var appBundleId: String?
    var miniVersion : String?
    var appleId : NSNumber?
    var appUrl : String?
    
    var certAccount: String?
    var resourceType : String?
    var editorDesc : String?
    var cornerIcon : String?
    
    var cornerName: String?
    var isVip : String?
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        
        appId <- map["appId"]
        appName <- map["appName"]
        appIntroduction <- map["appIntroduction"]
        appIcon <- map["appIcon"]
        
        appCategory <- map["appCategory"]
        appCategoryCode <- map["appCategoryCode"]
        avgScore <- map["avgScore"]
        appSize <- map["appSize"]
        
        appVersion <- map["appVersion"]
        downloadUrl <- map["downloadUrl"]
        supportIpad <- map["supportIpad"]
        supportIphone <- map["supportIphone"]
        
        appBundleId <- map["appBundleId"]
        miniVersion <- map["miniVersion"]
        appleId <- map["appleId"]
        appUrl <- map["appUrl"]
        
        certAccount <- map["certAccount"]
        resourceType <- map["resourceType"]
        editorDesc <- map["editorDesc"]
        cornerIcon <- map["cornerIcon"]
        
        cornerName <- map["cornerName"]
        isVip <- map["isVip"]
    }
}

class StatusObj: Mappable {
    
    var codeNum : NSNumber?
    var message : String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
        codeNum <- map["code"]
        message <- map["message"]
    }
}

