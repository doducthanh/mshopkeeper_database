//
//  User.swift
//  MShopKeeper
//
//  Created by ddthanh on 2/22/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import Foundation

class Account {
//   khai báo các thuộc tính của đối tượng account
    var username: String = ""
    var password: String = ""
    var userId: Int = 0
    var fullName: String = ""
    var tel: String = ""
    var email: String = ""
    var shop: [Shop]? = [Shop]()
    var avatar: String = ""
}
