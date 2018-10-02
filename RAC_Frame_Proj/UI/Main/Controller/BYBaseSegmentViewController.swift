//
//  BYBaseSegmentViewController.swift
//  RAC_Frame_Proj
//
//  Created by CoDancer on 2018/7/22.
//  Copyright © 2018年 IOS. All rights reserved.
//

import UIKit

class BYBaseSegmentViewController: BYViewController, UIScrollViewDelegate {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func loadView() {
        
        super.loadView()
        self.view.addSubview(contentScrollView)
        self.view.addSubview(segmentView)
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        contentScrollView.size = CGSize.init(width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        contentScrollView.topY = 0
        
        segmentView.size = CGSize.init(width: SCREEN_WIDTH, height: 74)
        segmentView.topY = NaviHeight
    }
    
    lazy var contentScrollView : UIScrollView = {
        () -> UIScrollView in
        
        let _scrollView = UIScrollView()
        _scrollView.backgroundColor = .clear
        _scrollView.layer.masksToBounds = true
        return _scrollView
    }()
    
    lazy var segmentView : MainSegmentView = {
        () -> MainSegmentView in
        
        let _segmentView = MainSegmentView()
        _segmentView.signalAction.observeValues({ (value) in
            
            self.btnDidTouchOfTag(tag: value as! Int)
        })
        return _segmentView
    }()
    
    var segmentTitles: [String]! {
        
        willSet(newValue) {
            self.segmentTitles = newValue
        }
        
        didSet {
            removeViewOrVC()
            addChildViewController()
            segmentView.titleArr = segmentTitles
            setScollViewContent()
            setUpOneChildController(idx: 0)
        }
    }
    
    func removeViewOrVC() {
        
        for obj in contentScrollView.subviews.enumerated() {
            obj.element.removeFromSuperview()
        }
        for obj in self.childViewControllers.enumerated() {
            obj.element.removeFromParentViewController()
        }
    }
    
    func addChildViewController() {}
    
    func setScollViewContent() {
        
        contentScrollView.contentSize = CGSize.init(width: CGFloat((segmentTitles?.count)!)*SCREEN_WIDTH, height: 0)
        contentScrollView.isPagingEnabled = true
        contentScrollView.showsHorizontalScrollIndicator = false
        contentScrollView.delegate = self
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let idx: Int = Int(contentScrollView.contentOffset.x / SCREEN_WIDTH)
        segmentView.segmentViewTitleSelected(i: Int(idx))
        setUpOneChildController(idx: idx)
    }
    
    func setUpOneChildController(idx: Int) {
        
        let x : CGFloat = CGFloat(idx * Int(SCREEN_WIDTH))
        let vc : UIViewController = self.childViewControllers[idx]
        if vc.view.superview != nil {
            return
        }
        
        vc.view.frame = CGRect.init(x: x, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        contentScrollView.addSubview(vc.view)
    }
    
    func btnDidTouchOfTag(tag: Int) {
        
        segmentView.segmentViewTitleSelected(i: tag)
        let x: CGFloat = CGFloat(tag * Int(SCREEN_WIDTH))
        contentScrollView.contentOffset = CGPoint.init(x: x, y: 0)
        
        setUpOneChildController(idx: tag)
    }

}
