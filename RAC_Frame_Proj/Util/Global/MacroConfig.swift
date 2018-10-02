//
//  MacroConfig.swift
//  RAC_Frame_Proj
//
//  Created by CoDancer on 2018/7/22.
//  Copyright © 2018年 IOS. All rights reserved.
//

import UIKit

var SCREEN_WIDTH : CGFloat = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let MAINSCREEN = UIScreen.main.bounds

let MAINSTATUSHEIGHT = UIApplication.shared.statusBarFrame.size.height
let NaviHeight : CGFloat = (MAINSTATUSHEIGHT>20.0 ? 88.0:64.0)
let NAVCENTERY : CGFloat = MAINSTATUSHEIGHT + (NaviHeight - MAINSTATUSHEIGHT)/2.0
let Is_PhoneX : Bool = (MAINSTATUSHEIGHT>20.0 ? true:false)

let NAVCTOOLH : CGFloat = (MAINSTATUSHEIGHT>20 ? 34:0)
let WTNAVITOOL : CGFloat = NAVCTOOLH + 50

var MainScale : CGFloat = UIScreen.main.scale
let MAINWINDOW = UIApplication.shared.delegate?.window
let CurrentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
let APPLICATION = UIApplication.shared

var UserDefault = UserDefaults.standard




let BASEKEY : String = "12345678"


