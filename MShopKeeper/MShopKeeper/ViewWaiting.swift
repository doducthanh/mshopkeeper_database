//
//  ViewWaiting.swift
//  MShopKeeper
//
//  Created by ddthanh on 2/7/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import UIKit

class ViewWaiting: UIView {
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var img_loading: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        UINib.init(nibName: "ViewWaiting", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

