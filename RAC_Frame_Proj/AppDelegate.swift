//
//  AppDelegate.swift
//  RAC_Frame_Proj
//
//  Created by CoDancer on 2018/7/21.
//  Copyright © 2018年 IOS. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        BYHelper.configRootController()
        return true
    }

    

}

