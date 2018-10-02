//
//  BYHomeView.swift
//  RAC_Frame_Proj
//
//  Created by CoDancer on 2018/8/8.
//  Copyright © 2018年 IOS. All rights reserved.
//

import UIKit
import Kingfisher
import Result
import ReactiveCocoa
import ReactiveSwift

class BYHomeFeatureHeaderView: UIView, NewPagedFlowViewDelegate, NewPagedFlowViewDataSource {
    
    let (signalAction, observerTap) = Signal<Any, NoError>.pipe()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.addSubview(bannerView)
        self.addSubview(popularView)
        self.addSubview(categoryView)
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        bannerView.topY = 0
        popularView.size = CGSize.init(width: self.width, height: 260)
        popularView.topY = bannerView.bottomY + 2
        
        categoryView.size = CGSize.init(width: self.width, height: 120)
        categoryView.topY = popularView.bottomY
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var bannerView : NewPagedFlowView = {
        () -> NewPagedFlowView in
        
        let _bannerView = NewPagedFlowView.init(frame: CGRect.init(x: 0, y: 0,
                                                                   width: SCREEN_WIDTH,
                                                                   height: (SCREEN_WIDTH - 32) * 0.5 + 40))
        _bannerView.delegate = self
        _bannerView.dataSource = self
        _bannerView.minimumPageAlpha = 0.1
        _bannerView.leftRightMargin = -15
        
        let pageControl = UIPageControl.init(frame: CGRect.init(x: 0, y: _bannerView.height - 45,
                                                                width: _bannerView.width, height: 8))
        _bannerView.pageControl = pageControl
        _bannerView.addSubview(pageControl)
        _bannerView.reloadData()
        return _bannerView
    }()
    
    lazy var popularView : HomePopularAppView = {
        () -> HomePopularAppView in
        
        let _popularView = HomePopularAppView()
        return _popularView
    }()
    
    lazy var categoryView : HomeCategoryView = {
        () -> HomeCategoryView in
        
        let _categoryView = HomeCategoryView()
        return _categoryView
    }()
    
    func sizeForPage(in flowView: NewPagedFlowView!) -> CGSize {
        
        return CGSize.init(width: SCREEN_WIDTH - 32, height: (SCREEN_WIDTH - 32) * 0.5)
    }
    
    func didSelectCell(_ subView: PGIndexBannerSubiew!, withSubViewIndex subIndex: Int) {
        
        let bannerModel = bannerModels[subIndex]
        self.observerTap.send(value: bannerModel)
    }
    
    func numberOfPages(in flowView: NewPagedFlowView!) -> Int {
        
        if bannerModels != nil {
            return bannerModels.count
        }else {
            return 0
        }
    }
    
    func flowView(_ flowView: NewPagedFlowView!, cellForPageAt index: Int) -> PGIndexBannerSubiew! {
        
        let bannerView = PGIndexBannerSubiew()
        bannerView.tag = index
        bannerView.layer.cornerRadius = 10
        bannerView.layer.masksToBounds = true
        let bannerModel = bannerModels[index]
        bannerView.mainImageView.kf.setImage(with: ImageResource(downloadURL: NSURL.init(string: bannerModel.pictureUrl!)! as URL))
        
        return bannerView
    }
    
    var bannerModels: [HomeBannerModel]! {
        
        willSet(newValue) {
            self.bannerModels = newValue
        }
        
        didSet {
            bannerView.reloadData()
        }
    }
    
    var popularModels: [AppModel]! {
        
        willSet(newValue) {
            self.popularModels = newValue
        }
        
        didSet {
            popularView.popularModels = popularModels
        }
    }
    
    var categoryModels: [HomeBannerModel]! {
        
        willSet(newValue) {
            self.categoryModels = newValue
        }
        
        didSet {
            categoryView.categoryModels = categoryModels
        }
    }

}
