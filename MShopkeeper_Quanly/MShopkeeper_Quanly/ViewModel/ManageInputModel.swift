//
//  ManageInputModel.swift
//  MShopKeeper
//
//  Created by ddthanh on 3/14/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import Foundation

/// định nghĩa các erorr
enum ErorrValidate {
    case textShort  // do dai ki tu < 6
    case invalid
}

/// quản lí các dữ liệu nhập của người dùng
class ManageInputModel {
    

    /// hàm kiểm tra dữ liệu text nhập vào
    ///
    /// - Parameter text: nội dung text
    /// - Returns: lỗi
    func checkValidateText(text: String) -> ErorrValidate {
        if text.count < 6 {
            return ErorrValidate.textShort
        }
        return ErorrValidate.invalid
    }
    

    /// hàm so sánh 2 password
    ///
    /// - Parameters:
    ///   - pass: pass
    ///   - rePass: pass được nhập lại
    /// - Returns: true/false.
    func compairPassword(pass: String, rePass: String) -> Bool {
        if pass == rePass {
            return true
        } else {
            return false
        }
    }
    
}
