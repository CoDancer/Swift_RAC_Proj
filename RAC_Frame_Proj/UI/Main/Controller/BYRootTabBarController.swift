//
//  BYRootTabBarController.swift
//  RAC_Frame_Proj
//
//  Created by CoDancer on 2018/7/21.
//  Copyright © 2018年 IOS. All rights reserved.
//

import UIKit

class BYRootTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.configControllers()
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        self.tabBar.addShadowOnTop()
        
        BYHelper.hideTabbarLine(tabBar: self.tabBar)
    }
    
    func configControllers() -> Void {
        
        let homeNavi = self.getNaviController(controller: BYHomeViewController(),
                                              title: "首页",
                                              defaultImgName: "tab_ic_home_default",
                                              selectedImgName: "tab_ic_home_selected")
        
        let gameNavi = self.getNaviController(controller: BYGameViewController(),
                                              title: "游戏",
                                              defaultImgName: "tab_ic_game_default",
                                              selectedImgName: "tab_ic_game_selected")
        
        let appNavi = self.getNaviController(controller: BYAppViewController(),
                                              title: "应用",
                                              defaultImgName: "tab_ic_app_default",
                                              selectedImgName: "tab_ic_app_selected")
        
        let rankNavi = self.getNaviController(controller: BYRankViewController(),
                                             title: "排行",
                                             defaultImgName: "tab_ic_rank_default",
                                             selectedImgName: "tab_ic_rank_selected")
        
        self.tabBar.backgroundColor = UIColor.white
        self.viewControllers = [homeNavi, gameNavi, appNavi, rankNavi]
    }
    
    func getNaviController(controller: UIViewController,
                           title: String,
                           defaultImgName: String,
                           selectedImgName: String) -> BaseNavigation {
        
        let selectedColor = NSDictionary.init(object: UIColor.black, forKey: NSAttributedStringKey.foregroundColor as NSCopying)
        let defaultImg = UIImage.init(named: defaultImgName)?.withRenderingMode(.alwaysOriginal)
        let selectedImg = UIImage.init(named: selectedImgName)?.withRenderingMode(.alwaysOriginal)
        
        controller.tabBarItem = UITabBarItem.init(title: title, image: defaultImg, selectedImage: selectedImg)
        controller.tabBarItem.titlePositionAdjustment = UIOffset.init(horizontal: 0, vertical: -2)
        controller.tabBarItem.setTitleTextAttributes(selectedColor as? [NSAttributedStringKey : Any], for: .normal)
        
        let naviController = BaseNavigation.init(rootViewController: controller)
        return naviController;
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        return true
    }

}
