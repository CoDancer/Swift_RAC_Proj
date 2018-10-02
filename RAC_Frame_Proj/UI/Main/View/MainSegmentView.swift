//
//  MainSegmentView.swift
//  RAC_Frame_Proj
//
//  Created by CoDancer on 2018/8/12.
//  Copyright © 2018年 IOS. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

class MainSegmentView: UIView {

    var titleBtnArr : [UIButton]?
    var selectedBtn : UIButton?
    let (signalAction, observerTap) = Signal<Any, NoError>.pipe()
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        if self.titleBtnArr == nil {
            return
        }else {
            let width : Int = 106
            let count = self.titleBtnArr?.count
            for obj in (titleBtnArr?.enumerated())! {
                obj.element.size = CGSize.init(width: width, height: 38)
                obj.element.centerX = SCREEN_WIDTH/2.0 - CGFloat((count! - obj.offset - 2) * (width + 13))
                obj.element.topY = 24
                
                obj.element.layer.cornerRadius = obj.element.height/2.0
                obj.element.layer.masksToBounds = true
                
                if obj.element == selectedBtn {
                    addShadow(flag: true, btn: obj.element)
                }else {
                    addShadow(flag: false, btn: obj.element)
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var titleArr: [String]! {
        
        willSet(newValue) {
            self.titleArr = newValue
        }
        
        didSet {
            
            var mutBtnArr = [UIButton]()
            for obj in titleArr.enumerated() {
                let btn = UIButton()
                btn.titleLabel?.adjustsFontSizeToFitWidth = true
                btn.tag = obj.offset
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
                btn.setTitle(obj.element, for: .normal)
                if obj.offset == 0 {
                    selectedBtn = btn
                    button(btn: btn, isSelected: true)
                }else {
                    button(btn: btn, isSelected: false)
                }
                mutBtnArr.append(btn)
                self.addSubview(btn)
                self.titleBtnDidTouch(btn: btn)
            }
            titleBtnArr = mutBtnArr
            self.setNeedsLayout()
        }
    }
    
    func button(btn: UIButton, isSelected: Bool) {
        
        if isSelected {
            btn.setTitleColor(.white, for: .normal)
            btn.backgroundColor = .black
        }else {
            btn.setTitleColor(UIColor.init(valueRGB: 0x383838), for: .normal)
            btn.backgroundColor = UIColor.init(valueRGB: 0xE5E5E5)
        }
    }
    
    func addShadow(flag: Bool, btn: UIButton) {
        
        let shadowPath = UIBezierPath.init(roundedRect: btn.bounds, cornerRadius: btn.height/2.0)
        btn.layer.masksToBounds = false
        btn.layer.shadowColor = !flag ? UIColor.clear.cgColor : UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize.init(width: 0, height: 2)
        btn.layer.shadowOpacity = 0.3
        btn.layer.shadowPath = shadowPath.cgPath
    }
    
    func titleBtnDidTouch(btn: UIButton) {
        
        btn.reactive.controlEvents(.touchUpInside).observeValues { (btn) in
            
            self.button(btn: self.selectedBtn!, isSelected: false)
            self.addShadow(flag: false, btn: self.selectedBtn!)
            
            self.button(btn: btn, isSelected: true)
            self.addShadow(flag: true, btn: btn)
            self.selectedBtn = btn
            self.observerTap.send(value: btn.tag)
        }
    }
    
    func segmentViewTitleSelected(i: Int) {
        
        let button = titleBtnArr![i]
        self.button(btn: self.selectedBtn!, isSelected: false)
        self.addShadow(flag: false, btn: self.selectedBtn!)
        
        self.button(btn: button, isSelected: true)
        self.addShadow(flag: true, btn: button)
        self.selectedBtn = button
        
    }
}
