//
//  ViewRadius.swift
//  MShopkeeper_Quanly
//
//  Created by Admin on 4/22/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

@IBDesignable class ViewRadius: UIView {

    
    @IBInspectable var radius : CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = true
        }
    }

}
