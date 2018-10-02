//
//  BYViewController.swift
//  RAC_Frame_Proj
//
//  Created by CoDancer on 2018/7/22.
//  Copyright © 2018年 IOS. All rights reserved.
//

import UIKit

class BYViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        BYHelper.customizeTranslucentNavigationBar(naviBar: (self.navigationController?.navigationBar)!)
        BYHelper.hideNaviViewLine(view: (self.navigationController?.navigationBar)!)
    }
    
    override func loadView() {
        
        super.loadView()
        configNaviView()
        searchView()
    }
    
    func configNaviView() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "nav_ic_download"),
                                                                      style: .plain,
                                                                      target: self,
                                                                      action: #selector(downloadCenterClick(sender:)))
        
        let leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 45, height: 32))
        let leftBtn = UIButton.init(type: .custom)
        leftBtn.frame = CGRect.init(x: 0, y: 0, width: 32, height: 32)
        leftBtn.layer.cornerRadius = leftBtn.height/2.0
        leftBtn.layer.masksToBounds = true
        leftView.addSubview(leftBtn)
        leftBtn.setBackgroundImage(UIImage.init(named: "icon_avatar"), for: .normal)
        leftBtn.reactive.controlEvents(.touchUpInside).observeValues { (obj) in
            
        }
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftView)
    }
    
    @objc func downloadCenterClick(sender: UIButton) {
        
    }
    
    func searchView() {
        
        let backView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH - 120, height: 44))
        backView.backgroundColor = .white
        let imgView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 20))
        imgView.image = UIImage.init(named: "nav_ic_search")
        imgView.leftX = -5
        imgView.centerY = backView.height/2.0
        imgView.isUserInteractionEnabled = true
        backView.addSubview(imgView)
        
        let label = UILabel.init(frame: CGRect.init(x: imgView.leftX + 20, y: 0, width: backView.width - 30, height: 44))
        label.text = "搜索游戏应用"
        label.textColor = UIColor.init(valueRGB: 0xC9CECF)
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.isUserInteractionEnabled = true
        backView.addSubview(label)
        
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(clickSearchView(sender:)))
        backView.addGestureRecognizer(tapGes)
        self.navigationItem.titleView = backView
    }
    
    @objc func clickSearchView(sender: UIGestureRecognizer) {
        
    }

}
