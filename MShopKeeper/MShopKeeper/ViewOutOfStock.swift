//
//  ViewOutOfStock.swift
//  MShopKeeper
//
//  Created by ddthanh on 2/5/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import UIKit

class ViewOutOfStock: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet var view: UIView!
    @IBOutlet weak var lbSKU: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var switchUI: UISwitch!

    override init(frame: CGRect) {
        super.init(frame: frame)
        UINib.init(nibName: "View", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        UINib.init(nibName: "View", bundle: nil).instantiate(withOwner: self, options: nil)
//        addSubview(view)
//        view.frame = self.bounds
    }
    
}
