//
//  HomeAppCell.swift
//  RAC_Frame_Proj
//
//  Created by CoDancer on 2018/8/13.
//  Copyright © 2018年 IOS. All rights reserved.
//

import UIKit
import Kingfisher

class HomeAppCell: UITableViewCell {
    
    lazy var appImgView : UIImageView = {
        () -> UIImageView in
        
        let _appImgView = UIImageView()
        _appImgView.contentMode = .scaleAspectFit
        return _appImgView
    }()
    
    lazy var markImg : UIImageView = {
        () -> UIImageView in
        
        let _markImg = UIImageView()
        _markImg.contentMode = .scaleAspectFit
        return _markImg
    }()
    
    lazy var appName : UILabel = {
        () -> UILabel in
        
        let _appName = UILabel()
        _appName.font = UIFont.systemFont(ofSize: 16.0)
        _appName.textColor = .black
        return _appName
    }()
    
    lazy var appStoreImg : UIImageView = {
        () -> UIImageView in
        
        let _imgView = UIImageView()
        _imgView.image = UIImage.init(named: "ic_AppStore")
        _imgView.isHidden = true
        return _imgView
    }()
    
    lazy var starImgView : AppStarsImgView = {
        () -> AppStarsImgView in
        
        let starImgView = AppStarsImgView()
        return starImgView
    }()
    
    lazy var sizeLabel : UILabel = {
        () -> UILabel in
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11.0)
        label.textColor = UIColor.init(valueRGB: 0xBCBCBC)
        return label
    }()
    
    lazy var infoLabel : UILabel = {
        () -> UILabel in
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textColor = UIColor.init(valueRGB: 0xBCBCBC)
        return label
    }()
    
    lazy var typeLabel : UILabel = {
        () -> UILabel in
        
        let label = UILabel()
        label.textColor = UIColor.init(valueRGB: 0xFF4C4C)
        label.font = UIFont.systemFont(ofSize: 12.0)
        return label
    }()
    
    lazy var downloadBtn : UIButton = {
        () -> UIButton in
        
        let btn = UIButton()
        btn.reactive.controlEvents(.touchUpInside).observeValues { (btn) in
            
        }
        return btn
    }()
    
    lazy var vipImg : UIImageView = {
        () -> UIImageView in
        
        let _imgView = UIImageView()
        _imgView.image = UIImage.init(named: "ic_vip")
        return _imgView
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        self.contentView.addSubview(appImgView)
        self.contentView.addSubview(markImg)
        self.contentView.addSubview(appName)
        self.contentView.addSubview(appStoreImg)
        
        self.contentView.addSubview(starImgView)
        self.contentView.addSubview(sizeLabel)
        self.contentView.addSubview(infoLabel)
        self.contentView.addSubview(typeLabel)
        
        self.contentView.addSubview(downloadBtn)
        self.contentView.addSubview(vipImg)
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        appImgView.size = CGSize.init(width: 72, height: 72)
        appImgView.leftX = 16
        appImgView.centerY = self.contentView.height/2.0
        appImgView.layer.cornerRadius = 14.0
        appImgView.layer.masksToBounds = true
        
        markImg.size = CGSize.init(width: 25, height: 25)
        markImg.topY = appImgView.topY
        markImg.leftX = appImgView.leftX
        
        appName.sizeToFit()
        appName.leftX = appImgView.rightX + 10
        appName.topY = appImgView.topY
        
        appStoreImg.sizeToFit()
        appStoreImg.leftX = appName.rightX + 8
        appStoreImg.centerY = appName.centerY - 2
        
        starImgView.size = CGSize.init(width: 100, height: 17)
        starImgView.topY = appName.bottomY + 2
        starImgView.leftX = appName.leftX
        
        sizeLabel.sizeToFit()
        sizeLabel.leftX = starImgView.rightX + 10
        sizeLabel.centerY = starImgView.centerY
        
        infoLabel.size = CGSize.init(width: self.contentView.width - starImgView.leftX - 100, height: 17)
        infoLabel.leftX = starImgView.leftX
        infoLabel.topY = starImgView.bottomY + 2
        
        typeLabel.sizeToFit()
        typeLabel.leftX = infoLabel.leftX
        typeLabel.topY = infoLabel.bottomY + 2
        
        downloadBtn.size = CGSize.init(width: 64, height: 34)
        downloadBtn.rightX = self.contentView.width - 16
        downloadBtn.centerY = appImgView.centerY
        downloadBtn.layer.cornerRadius = downloadBtn.height/2.0
        
        vipImg.sizeToFit()
        vipImg.rightX = appImgView.rightX
        vipImg.bottomY = appImgView.bottomY
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var cellModel: AppModel! {
        
        willSet(newValue) {
            self.cellModel = newValue
        }
        
        didSet {
            appImgView.kf.setImage(with: ImageResource(downloadURL: NSURL.init(string: cellModel.appIcon!)! as URL))
            markImg.kf.setImage(with: ImageResource(downloadURL: NSURL.init(string: cellModel.cornerIcon!)! as URL))
            appName.text = cellModel.appName
            starImgView.addStarsToViewWithNumber(num: cellModel.avgScore!)
            sizeLabel.text = cellModel.appSize!
            infoLabel.text = cellModel.appIntroduction!
            typeLabel.text = "•" + cellModel.appCategory!
            vipImg.isHidden = !(cellModel.isVip == "1")
            downloadBtn.setTitle("安装", for: .normal)
            downloadBtn.backgroundColor = UIColor.init(valueRGB: 0x47C85B)
            downloadBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
            self.setNeedsLayout()
        }
    }

}


class AppStarsImgView: UIView {
    
    var starsArr : [UIImageView]!
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        for obj in starsArr.enumerated() {
            obj.element.size = CGSize.init(width: 14, height: 14)
            obj.element.leftX = CGFloat(obj.offset) * obj.element.width
            obj.element.centerY = self.height/2.0
        }
    }
    
    func addStarsToViewWithNumber(num: NSNumber) {
        
        for view in self.subviews {
            view.removeFromSuperview()
        }
        self.addSubview(numberLabel)
        numberLabel.text = "\(num)"
        
        let numberInt: Int = Int(floor(num.floatValue))
        var mutStarsArr = [UIImageView]()
        if numberInt != 0 {
            for _ in 0..<numberInt {
                let imgView = UIImageView()
                imgView.image = UIImage.init(named: "home_appdetail_ic_star_green")
                mutStarsArr.append(imgView)
                self.addSubview(imgView)
            }
            if num.floatValue - Float(numberInt) >= 0.5 {
                let imgView = UIImageView()
                imgView.image = UIImage.init(named: "home_appdetail_ic_star_half")
                mutStarsArr.append(imgView)
                self.addSubview(imgView)
            }
            for _ in 0..<(5 - mutStarsArr.count) {
                if 5 - mutStarsArr.count == 0 {
                    return
                }
                let imgView = UIImageView()
                imgView.image = UIImage.init(named: "home_appdetail_ic_star_gray")
                mutStarsArr.append(imgView)
                self.addSubview(imgView)
            }
        }else {
            for _ in 0..<5 {
                let imgView = UIImageView()
                imgView.image = UIImage.init(named: "home_appdetail_ic_star_gray")
                mutStarsArr.append(imgView)
                self.addSubview(imgView)
            }
        }
        starsArr = mutStarsArr
    }
    
    lazy var numberLabel : UILabel = {
        () -> UILabel in
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textColor = UIColor.init(white: 0.0, alpha: 0.8)
        return label
    }()
}
