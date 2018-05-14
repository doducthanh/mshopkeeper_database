//
//  CommonVariable.swift
//  MShopKeeper
//
//  Created by ddthanh on 2/23/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import Foundation
//dịnh nghĩa các biến dùng chung trong project
enum ConnectStatus: Int {
    case sucess = 200
    case erorr = 500
}

class CommonVariable: NSObject{
    
    static var USER: Account!
    static var isDisConnect = false
    static var isSelectShopCurrent = true
    static var numberRowAddress = 0
    static var shopOfficial: Shop!
    static var arrayShopDepend: [Shop]!
}
