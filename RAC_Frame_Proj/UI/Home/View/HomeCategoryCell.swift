//
//  HomeCategoryCell.swift
//  RAC_Frame_Proj
//
//  Created by CoDancer on 2018/8/13.
//  Copyright © 2018年 IOS. All rights reserved.
//

import UIKit
import Kingfisher

class HomeCategoryCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.addSubview(imgView)
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        imgView.size = CGSize.init(width: 152, height: 76)
        imgView.centerX = self.width/2.0
        imgView.centerY = self.height/2.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imgView : UIImageView = {
        () -> UIImageView in
        
        let _imgView = UIImageView()
        _imgView.layer.cornerRadius = 10
        _imgView.layer.masksToBounds = true
        _imgView.isUserInteractionEnabled = true
        _imgView.backgroundColor = UIColor.init(valueRGB: 0xF5F5F5)
        return _imgView
    }()
    
    var cellModel: HomeBannerModel! {
        
        willSet(newValue) {
            self.cellModel = newValue
        }
        
        didSet {
            imgView.kf.setImage(with: ImageResource(downloadURL: NSURL.init(string: cellModel.pictureUrl!)! as URL))
        }
    }
}
