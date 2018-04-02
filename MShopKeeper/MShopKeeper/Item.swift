//
//  Item.swift
//  MShopKeeper
//
//  Created by ddthanh on 2/5/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import Foundation
import UIKit
//đối tượng item
class Item {
//    khai báo các thuộc tính của đối tượng item
    var itemId = 0
    var modelID = 0
    var SKUCode: String = ""
    var itemType: Int = 0
    var decription: String = ""
    var unitPrice: Int = 0
    var modeType: Int = 0
    var isDisplayPrice: Bool = true
    var isPromotion = false
    var percentPromotion = 0.0
    var color = ""
    var size = ""
    var addressShop = ""
    var addressStock = ""
    var shopID = 0
    var stockID = 0
    var barCode = ""
    init() {
        
    }
}

enum ColorItem: Int{
    case white = 0, black, red, yellow, blue, violet, orange
}

enum Size: Int{
    case S = 0, M, L
}
