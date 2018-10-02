//
//  HomeCategoryView.swift
//  RAC_Frame_Proj
//
//  Created by CoDancer on 2018/8/13.
//  Copyright © 2018年 IOS. All rights reserved.
//

import UIKit

class HomeCategoryView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    static let HomeCategoryCellIdentifier = "HomeCategoryCellIdentifier"

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.addSubview(collView)
        self.backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        collView.frame = self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collView : UICollectionView = {
        () -> UICollectionView in
        
        let layout = UICollectionViewFlowLayout()
        let itemW : CGFloat = 165
        let itemH : CGFloat = 95
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize.init(width: itemW, height: itemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let _collView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        _collView.contentInset = UIEdgeInsetsMake(0, 8, 0, 8)
        _collView.backgroundColor = .white
        _collView.dataSource = self
        _collView.delegate = self
        _collView.showsHorizontalScrollIndicator = false
        _collView.register(HomeCategoryCell.self, forCellWithReuseIdentifier: HomeCategoryView.HomeCategoryCellIdentifier)
        return _collView
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if categoryModels != nil {
            return categoryModels.count
        }else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCategoryView.HomeCategoryCellIdentifier,
                                                      for: indexPath) as! HomeCategoryCell
        cell.cellModel = categoryModels[indexPath.item]
        return cell
    }
    
    var categoryModels: [HomeBannerModel]! {
        
        willSet(newValue) {
            self.categoryModels = newValue
        }
        
        didSet {
            collView.reloadData()
        }
    }

}
