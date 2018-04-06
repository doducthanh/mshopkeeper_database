//
//  ButtonSelect.swift
//  MShopKeeper
//
//  Created by Admin on 4/6/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import Foundation
import UIKit

class ButtonSelect : UIButton{
    
    var viewCustom: UIView!
    var label: UILabel!
    var image: UIImageView!
    var select: Bool!
    var delegate: ButtonModeProtocol!
    
    func drawButton(frame: CGRect, lbText: String, img: UIImage) -> UIButton {
        viewCustom = UIView.init(frame: frame)
        viewCustom.layer.cornerRadius = 10
        viewCustom.backgroundColor = UIColor.gray
        viewCustom.layer.shadowColor = UIColor.black.cgColor
        viewCustom.layer.shadowRadius = 2
        viewCustom.layer.shadowOffset = CGSize.init(width: 2, height: 3)
        viewCustom.layer.masksToBounds = true
        
        image = UIImageView.init(frame: CGRect.init(x: frame.width - 50, y: 0, width: 40, height: 40))
        image.layer.cornerRadius = 45/2
        image.image = UIImage.init(named: "icon_round_gray")
        viewCustom.addSubview(image)
        
        label = UILabel.init(frame: CGRect.init(x: 20, y: 0, width: frame.width - 80, height: frame.height))
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        viewCustom.addSubview(label)
        select = false
        
        self.addSubview(viewCustom)
        return self
    }
}

protocol ButtonSelectDelegate {
    func onClick ()
}
