//
//  HomeFeatruedVC.swift
//  RAC_Frame_Proj
//
//  Created by CoDancer on 2018/8/12.
//  Copyright © 2018年 IOS. All rights reserved.
//

import UIKit
import MBProgressHUD

class HomeFeatruedVC: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        dataRequest()
    }
    
    override func loadView() {
        
        super.loadView()
        self.view.addSubview(tableView)
        tableView.tableHeaderView = headerView
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        tableView.size = CGSize.init(width: SCREEN_WIDTH, height: SCREEN_HEIGHT - NaviHeight - 70)
        tableView.topY = NaviHeight + 70
    }
    
    lazy var headerView : BYHomeFeatureHeaderView = {
        () -> BYHomeFeatureHeaderView in
        
        let _headerView = BYHomeFeatureHeaderView()
        let height: CGFloat = (SCREEN_WIDTH - 32) * 0.5 + 40 + 260 + 120
        _headerView.size = CGSize.init(width: SCREEN_WIDTH, height: height)
        return _headerView
    }()
    
    lazy var tableView : AppTableView = {
        () -> AppTableView in
        
        let _tableView = AppTableView.init(frame: .zero, style: .plain)
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, WTNAVITOOL, 0)
        return _tableView
    }()
    
    func dataRequest() {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        BYHomeViewModel().getHomeDataRequest(page: 0) { (homeModel) in
            
            MBProgressHUD.hide(for: self.view, animated: true)
            
            if homeModel.requestType == .RequestSuccessful {
                
                self.headerView.bannerModels = homeModel.dataModel?.homeBannerModels
                self.headerView.popularModels = homeModel.dataModel?.homeHotModels
                self.headerView.categoryModels = homeModel.dataModel?.homeSpecialModels
                self.tableView.dataModels = homeModel.dataModel?.homeSelectedModels
                
            }else {
                
                BYHelper.showViewDidResAbnormal(resultModel: homeModel)
            }
        }
    }

}
