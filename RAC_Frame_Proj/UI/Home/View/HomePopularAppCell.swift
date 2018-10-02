//
//  HomePopularAppCell.swift
//  RAC_Frame_Proj
//
//  Created by CoDancer on 2018/8/13.
//  Copyright © 2018年 IOS. All rights reserved.
//

import UIKit
import Kingfisher

class HomePopularAppCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.addSubview(imgView)
        self.addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        imgView.size = CGSize.init(width: 70, height: 70)
        imgView.topY = 10
        imgView.centerX = self.width/2.0
        
        titleLabel.size = CGSize.init(width: imgView.width + 3, height: 14)
        titleLabel.centerX = imgView.centerX
        titleLabel.topY = imgView.bottomY + 6
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imgView : UIImageView = {
        () -> UIImageView in
        
        let _imgView = UIImageView()
        _imgView.layer.cornerRadius = 10
        _imgView.layer.masksToBounds = true
        return _imgView
    }()
    
    lazy var titleLabel : UILabel = {
        () -> UILabel in
        
        let _titleLabel = UILabel()
        _titleLabel.font = UIFont.systemFont(ofSize: 12.0)
        _titleLabel.textColor = .black
        _titleLabel.textAlignment = .center
        return _titleLabel
    }()
    
    var cellModel: AppModel! {
        
        willSet(newValue) {
            self.cellModel = newValue
        }
        
        didSet {
            imgView.kf.setImage(with: ImageResource(downloadURL: NSURL.init(string: cellModel.appIcon!)! as URL))
            titleLabel.text = cellModel.appName
            self.setNeedsLayout()
        }
    }
    
}
