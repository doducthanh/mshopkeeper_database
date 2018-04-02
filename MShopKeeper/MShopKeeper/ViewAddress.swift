//
//  ViewAddress.swift
//  MShopKeeper
//
//  Created by ddthanh on 3/26/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import UIKit

class ViewAddress: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(address: String, count: Int) {
        let lbAddress = UILabel.init()
        lbAddress.frame = CGRect.init(x: 10, y: 0, width: self.frame.width - 50, height: 40)
        lbAddress.text = address
        self.addSubview(lbAddress)
        
        let lbCount = UILabel.init()
        lbCount.frame = CGRect.init(x: self.frame.width - 50, y: 5, width: 30, height: 30)
        lbCount.backgroundColor = UIColor.gray
        lbCount.textAlignment = .center
        lbCount.font = UIFont.boldSystemFont(ofSize: 15)
        lbCount.textColor = .white
        lbCount.text = count.description
        self.addSubview(lbCount)
    }

}
