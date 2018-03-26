//
//  Shop.swift
//  MShopKeeper
//
//  Created by ddthanh on 3/9/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import Foundation

class Shop {
    
    var shopID: String! = ""
    var shopCode: String! = ""
    var shopName: String! = ""
    var contactName: String! = ""
    var numberBranch: Int = 0
    var numberStock: Int = 0
    var startDate: Date?
    var expireDate: Date?
    var stocks: [Stock]?
    var suppliers: [Supplier]?
    
    init(shopID: String, shopCode: String, shopName: String, contactName: String) {
        self.shopID = shopID
        self.shopCode = shopCode
        self.shopName = shopName
        self.contactName = contactName
    }
    
}
