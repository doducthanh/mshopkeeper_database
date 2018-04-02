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
    
    /// hàm khởi tạo view animation
    ///
    /// - Parameters:
    ///   - frame: toạ độ, kích thước của view
    ///   - supperview: nơi mà view animation đươc add vào
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
    
    /// hàm bắt đầu thực hiện animation
    func startAnimatonWaiting() {
        viewWaiting.isHidden = false
    }
    
    /// hàm kết thúc animation.
    func endAnimationWaiting() {
        viewWaiting.isHidden = true
    }
    
    
}
