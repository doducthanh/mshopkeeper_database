//
//  CustomNavigationBar.swift
//  MShopKeeper
//
//  Created by ddthanh on 1/30/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import UIKit

class CustomNavigationBar: UIView {
    //MARK: Property
//    var viewHeader: UIView!
    //khai báo các thành phần của view custom
    var heightBar: CGFloat!
    var btMenu: UIButton!
    var btScan: UIButton!
    var btSearch: UIButton!
    var btBack: UIButton!
    var lbTitle: UILabel!
    var textfieldSearch: UITextField!
    var delegate: CustomNavigationBarDelegate!
    
    //vẽ các thành phần
    override init(frame: CGRect) {
        super.init(frame: frame)
        heightBar = frame.size.height
        btMenu = UIButton.init()
        btMenu.backgroundColor = .clear
        btMenu.frame = CGRect.init(x: 10, y: -5, width: heightBar + 20, height: heightBar + 10)
        btMenu.addTarget(self, action: #selector(tapSlideMenu), for: .touchUpInside)
        btMenu.setImage(UIImage.init(named: "ic_btn_slidemenu"), for: .normal)
        btMenu.imageEdgeInsets = UIEdgeInsetsMake(10, 0, 10, 20)
        self.addSubview(btMenu)
        
        lbTitle = UILabel.init()
        lbTitle.frame = CGRect.init(x: btMenu.frame.size.width + 10, y: 0, width: 160, height: heightBar)
        lbTitle.text = "Tư vấn bán hàng"
        lbTitle.font = UIFont.boldSystemFont(ofSize: 16)
        lbTitle.textColor = .white
        self.addSubview(lbTitle)
        
        btScan = UIButton.init()
        btScan.frame = CGRect.init(x: self.frame.size.width - heightBar - 15, y: 0, width: heightBar, height: heightBar)
        btScan.addTarget(self, action: #selector(tapScanCode), for: .touchUpOutside)
        btScan.setImage(UIImage.init(named: "ic_scan_barcode"), for: .normal)
        self.addSubview(btScan)
        
        btSearch = UIButton.init()
        btSearch.frame = CGRect.init(x: self.frame.size.width - 2*heightBar - 25, y: 0, width: heightBar, height: heightBar)
        btSearch.setImage(UIImage.init(named: "ic_search_white"), for: .normal)
        btSearch.addTarget(self, action: #selector(tapSearchButton), for: .touchUpInside)
        self.addSubview(btSearch)
        
        btBack = UIButton.init()
        btBack.frame = CGRect.init(x: 15, y: 0, width: heightBar, height: heightBar)
        btBack.addTarget(self, action: #selector(tapBackButton), for: .touchUpInside)
        btBack.setImage(UIImage.init(named: "ic_back"), for: .normal)
        self.addSubview(btBack)
        btBack.isHidden = true
        
        textfieldSearch = UITextField.init()
        textfieldSearch.frame = CGRect.init(x: lbTitle.frame.origin.x, y: 0, width: self.frame.width - 2*lbTitle.frame.origin.x, height: heightBar+5)
        textfieldSearch.backgroundColor = .white
        textfieldSearch.font = UIFont.systemFont(ofSize: 13)
        textfieldSearch.borderStyle = .roundedRect
        textfieldSearch.returnKeyType = .search
        textfieldSearch.clearButtonMode = .whileEditing
        textfieldSearch.placeholder = "Tên hàng hoá, mã vạch, mã ..."
        self.addSubview(textfieldSearch)
        textfieldSearch.isHidden = true
        //self.addSubview(viewHeader)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapSlideMenu(){
        delegate.tapSlideMenu()
    }

    @objc func tapBackButton(){
        delegate.tapBackButton()
    }
    
    @objc func tapSearchButton(){
        delegate.tapSearchButton()
    }
    
    @objc func tapScanCode(){
        delegate.tapScanCode()
    }
}

protocol CustomNavigationBarDelegate {
    func tapSlideMenu()
    func tapBackButton()
    func tapSearchButton()
    func tapScanCode()
}
