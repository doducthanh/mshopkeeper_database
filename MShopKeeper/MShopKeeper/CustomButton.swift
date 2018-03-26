//
//  CustomButton.swift
//  MShopKeeper
//
//  Created by ddthanh on 1/30/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    var height: Float = 50
    var width: Float = 80
    let image = UIImage.init(named: "ic_cart_red")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: private function
    func setUpButton(){
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
        self.backgroundColor = MyColors.BACKGROUND_BUTTON_DEFAULT
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.setTitleColor(UIColor.gray, for: .normal)
        
        let img = UIImageView.init()
        img.frame = CGRect.init(x: self.frame.size.width - self.frame.size.height/2 + 5, y: 5, width: self.frame.height/2 - 10, height: self.frame.height/2 - 10)
        img.image = image
        self.addSubview(img)
    }
    
    func onTapButton(){
        self.backgroundColor = UIColor.white
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.borderWidth = 2
    }
    
    func setButtonOnClick() {
        self.backgroundColor = .white
        self.setTitleColor(MyColors.BLUE, for: .normal)
        self.layer.borderColor = MyColors.BLUE.cgColor
        self.layer.borderWidth = 1
        self.alpha = 1.0
    }
    
    func setButtonNotOnClick() {
        self.backgroundColor = MyColors.BACKGROUND_BUTTON_DEFAULT
        self.setTitleColor(UIColor.gray, for: .normal)
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
        self.alpha = 1.0
    }
    
}
