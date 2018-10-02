//
//  HomePopularAppView.swift
//  RAC_Frame_Proj
//
//  Created by CoDancer on 2018/8/13.
//  Copyright © 2018年 IOS. All rights reserved.
//

import UIKit

class HomePopularAppView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    static let HomeAppCellIdentifier = "HomeAppCellIdentifier"

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.addSubview(titleMark)
        self.addSubview(collView)
        self.backgroundColor = .white
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        titleMark.sizeToFit()
        titleMark.leftX = 16
        titleMark.topY = 6
        
        collView.size = CGSize.init(width: self.width - 12, height: self.height - titleMark.bottomY - 8)
        collView.topY = titleMark.bottomY + 5
        collView.centerX = self.width/2.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleMark : UIButton = {
        () -> UIButton in
        
        let _titleMark = UIButton()
        _titleMark.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        _titleMark.setImage(UIImage.init(named: "home_ic_hot"), for: .normal)
        _titleMark.setTitle("大家都在玩", for: .normal)
        _titleMark.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, -3)
        _titleMark.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 3)
        _titleMark.setTitleColor(.black, for: .normal)
        return _titleMark
    }()
    
    lazy var collView : UICollectionView = {
        () -> UICollectionView in
        
        let layout = UICollectionViewFlowLayout()
        let itemW = (SCREEN_WIDTH - 12)/4.0
        let itemH : CGFloat = 105
        layout.itemSize = CGSize.init(width: itemW, height: itemH)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 0
        
        let _collView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        _collView.backgroundColor = .clear
        _collView.dataSource = self
        _collView.delegate = self
        _collView.showsHorizontalScrollIndicator = false
        _collView.isScrollEnabled = false
        _collView.register(HomePopularAppCell.self, forCellWithReuseIdentifier: HomePopularAppView.HomeAppCellIdentifier)
        return _collView
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if popularModels != nil {
            return popularModels.count
        }else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomePopularAppView.HomeAppCellIdentifier,
                                                                           for: indexPath) as! HomePopularAppCell
        cell.cellModel = popularModels[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    var popularModels: [AppModel]! {
        
        willSet(newValue) {
            self.popularModels = newValue
        }
        
        didSet {
            self.collView.reloadData()
        }
    }
    
}
