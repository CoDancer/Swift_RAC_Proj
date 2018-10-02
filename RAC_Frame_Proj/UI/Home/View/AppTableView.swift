//
//  AppTableView.swift
//  RAC_Frame_Proj
//
//  Created by CoDancer on 2018/8/13.
//  Copyright © 2018年 IOS. All rights reserved.
//

import UIKit

class AppTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    static let AppCellIdentifier = "UserAppCollectCellIdentifier"

    override init(frame: CGRect, style: UITableViewStyle) {
        
        super.init(frame: frame, style: style)
        self.separatorStyle = .none
        self.delegate = self
        self.dataSource = self
        self.showsVerticalScrollIndicator = false
        self.register(HomeAppCell.self, forCellReuseIdentifier: AppTableView.AppCellIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if dataModels != nil {
            return dataModels.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AppTableView.AppCellIdentifier) as? HomeAppCell
        let cellModel = dataModels[indexPath.row]
        cell?.cellModel = cellModel
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 92
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
    }
    
    var dataModels: [AppModel]! {
        
        willSet(newValue) {
            self.dataModels = newValue
        }
        
        didSet {
            self.reloadData()
        }
    }

}
