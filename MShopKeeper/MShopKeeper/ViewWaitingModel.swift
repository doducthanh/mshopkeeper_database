//
//  ViewWaitingModel.swift
//  MShopKeeper
//
//  Created by ddthanh on 3/13/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import Foundation
import UIKit

// vẽ view animation wait
class ViewWaitingModel {
    
    var viewWaiting: ViewWaiting!
    
    init(frame: CGRect, supperview: UIViewController) {
        viewWaiting = ViewWaiting.init(frame: frame)
        supperview.view.addSubview(viewWaiting)
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2.0)
        rotateAnimation.duration = 1.0
        rotateAnimation.repeatCount = 10
        viewWaiting.img_loading.layer.add(rotateAnimation, forKey: nil)
        viewWaiting.isHidden = true
    }
    
    func startAnimatonWaiting() {
        viewWaiting.isHidden = false
    }
    
    func endAnimationWaiting() {
        viewWaiting.isHidden = true
    }
    
    
}
