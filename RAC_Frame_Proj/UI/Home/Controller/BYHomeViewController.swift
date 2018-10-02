//
//  BYHomeViewController.swift
//  RAC_Frame_Proj
//
//  Created by CoDancer on 2018/7/22.
//  Copyright © 2018年 IOS. All rights reserved.
//

import UIKit

class BYHomeViewController: BYBaseSegmentViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func loadView() {
        
        super.loadView()
        segmentTitles = ["精选","专题","限免"]
    }
    
    override func addChildViewController() {
        
        let featureVC : HomeFeatruedVC = HomeFeatruedVC()
        let topicsVC : HomeTopicsVC = HomeTopicsVC()
        let exemptionVC : HomeExemptionVC = HomeExemptionVC()
        
        self.addChildViewController(featureVC)
        self.addChildViewController(topicsVC)
        self.addChildViewController(exemptionVC)
    }
    
}
