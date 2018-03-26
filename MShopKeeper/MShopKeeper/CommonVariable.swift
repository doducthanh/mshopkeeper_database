//
//  CommonVariable.swift
//  MShopKeeper
//
//  Created by ddthanh on 2/23/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import Foundation

enum ConnectStatus: Int {
    case sucess = 200
    case erorr = 500
}

class CommonVariable: NSObject{
    
    static var USER: Account!
    static var isDisConnect = false
    
}
