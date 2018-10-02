//
//  BYHelper.swift
//  RAC_Frame_Proj
//
//  Created by CoDancer on 2018/7/22.
//  Copyright © 2018年 IOS. All rights reserved.
//

import UIKit
import RealmSwift
import MBProgressHUD

class BYHelper: NSObject {
    
    class func configRootController() -> Void {
        
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window = UIWindow.init(frame: MAINSCREEN)
        appDelegate.window?.backgroundColor = UIColor.white
        appDelegate.window?.rootViewController = BYRootTabBarController()
        appDelegate.window?.makeKeyAndVisible()
    }
    
    class func hideTabbarLine(tabBar: UITabBar) -> Void {
        
        let rect: CGRect = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 49)
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(UIColor.clear.cgColor)
        context.fill(rect)
        
        let img: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        tabBar.backgroundImage = img
        tabBar.shadowImage = img
    }
    
    class func currentTimeStamp() -> String {
        
        let now = Date()
        let timeInterval:TimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return "\(timeStamp)"
    }
    
    class func hideNaviViewLine(view: UIView) {
        
        if (view.isKind(of: UIImageView.self) && view.height <= 1.0) {
            view.isHidden = true
            return;
        }
        for subView in view.subviews {
            self.hideNaviViewLine(view: subView)
        }
    }
    
    class func paramsSerialized(params: Dictionary<String, String>) -> String {
        
        let keyArr = [String](params.keys)
        let sortedNameArr = keyArr.sorted { (obj1, obj2) -> Bool in
            return obj1 < obj2
        }
        
        var  strings = Array<String>()
        for obj in sortedNameArr {
            strings.append(obj + "=" + params[obj]!)
        }
        
        let paramString = strings.joined(separator: "&")
        
        return paramString
        
    }
    
    class func customizeTranslucentNavigationBar(naviBar: UINavigationBar) -> Void {
        
        naviBar.titleTextAttributes = [kCTForegroundColorAttributeName:UIColor.white] as [NSAttributedStringKey : Any]
        naviBar.tintColor = UIColor.black
        naviBar.isTranslucent = true
        naviBar.setBackgroundImage(UIImage(), for: .default)
        naviBar.shadowImage = UIImage()
    }
    
    class func configRealm() {
        /// 如果要存储的数据模型属性发生变化,需要配置当前版本号比之前大
        let dbVersion : UInt64 = 2
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String
        let dbPath = docPath.appending("/defaultDB.realm")
        let config = Realm.Configuration(fileURL: URL.init(string: dbPath), inMemoryIdentifier: nil, syncConfiguration: nil, encryptionKey: nil, readOnly: false, schemaVersion: dbVersion, migrationBlock: { (migration, oldSchemaVersion) in
            
        }, deleteRealmIfMigrationNeeded: false, shouldCompactOnLaunch: nil, objectTypes: nil)
        Realm.Configuration.defaultConfiguration = config
        Realm.asyncOpen { (realm, error) in
            if let _ = realm {
                print("Realm 服务器配置成功!")
            }else if let error = error {
                print("Realm 数据库配置失败：\(error.localizedDescription)")
            }
        }
    }
    
    class func showViewDidResAbnormal(resultModel: BaseResultModel) {
        
        if resultModel.requestType == .RequestTokenIsInvalid {
            
            self.showAlertView(message: "您的账号已在别的设备上登录，是否重新登录？") { (idx) in
                
                if idx == 0 {
                    
                    self.controllerOf(type: .topVC_type)?.navigationController?.popViewController(animated: true)
                }else {
                    
                    //弹出登录界面
                }
            }
        }else if (resultModel.requestType == .RequestFail || resultModel.requestType == .RequestNetError) {
            
            self.showHudOnView(view: (self.controllerOf(type: .topVC_type)?.view)!, withMsg: resultModel.msg)
        }
    }
    
    class func showHudOnView(view: UIView, withMsg msg: String) {
        
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .text
        hud.detailsLabel.text = msg
        hud.hide(animated: true, afterDelay: 2.0)
    }
    
    class func controllerOf(type: VC_type) -> UIViewController? {
        
        return self.controllerWithRootViewController(viewController: self.getCurrentWindow()?.rootViewController, type: type)
    }
    
    class func controllerWithRootViewController(viewController :UIViewController?, type: VC_type) -> UIViewController? {
        
        if viewController == nil {
            
            return nil
        }
        
        if viewController?.presentedViewController != nil {
            
            return self.controllerWithRootViewController(viewController: viewController?.presentedViewController!,
                                                         type: type)
        }
        else if viewController?.isKind(of: UITabBarController.self) == true {
            
            return self.controllerWithRootViewController(viewController: (viewController as! UITabBarController).selectedViewController,
                                                         type: type)
        }
        else if viewController?.isKind(of: UINavigationController.self) == true {
            
            if type == .navi_type {
                return viewController
            }else {
                return self.controllerWithRootViewController(viewController: (viewController as! UINavigationController).visibleViewController,
                                                             type: type)
            }
            
        }
        else {
            
            return viewController
        }
    }
    
    // 找到当前显示的window
    class func getCurrentWindow() -> UIWindow? {
        
        // 找到当前显示的UIWindow
        var window: UIWindow? = UIApplication.shared.keyWindow
        /**
         window有一个属性：windowLevel
         当 windowLevel == UIWindowLevelNormal 的时候，表示这个window是当前屏幕正在显示的window
         */
        if window?.windowLevel != UIWindowLevelNormal {
            
            for tempWindow in UIApplication.shared.windows {
                
                if tempWindow.windowLevel == UIWindowLevelNormal {
                    
                    window = tempWindow
                    break
                }
            }
        }
        
        return window
    }
    
    class func showAlertView(message: String, completed completion: ((_ index: Int) -> Swift.Void)? = nil) {  //调用系统的弹视窗
        
        let alertController = UIAlertController.init(title: nil, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel) { (action) in
            if completion != nil {
                completion!(0)
            }
        }
        alertController.addAction(cancelAction)
        
        let okAction = UIAlertAction.init(title: "确定", style: .destructive) { (action) in
            if completion != nil {
                completion!(1)
            }
        }
        alertController.addAction(okAction)
        
        self.controllerOf(type: .topVC_type)?.present(alertController, animated: true, completion: nil)
    }

}
