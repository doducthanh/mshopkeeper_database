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
    
    func addLabelAddress(arrayAddress: [String], arrayCount: [Int]) -> UIView {
        for index in 0..<arrayAddress.count {
            let label = UILabel.init()
            label.frame = CGRect.init(x: 0, y: index * 30, width: Int(self.frame.width), height: 30)
            label.text = arrayAddress[index]
            self.addSubview(label)
        }
        return self
    }

}
