//
//  Constant.swift
//  MShopKeeper
//
//  Created by ddthanh on 3/19/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import Foundation
import UIKit
//dịnh nghĩa các hằng dùng trong project
class Constant {
    static let share = Constant()
    public static let Currency_Unit = "K"
    
    //hàm hiển thị khi mất internet
    func disConnection(supperView: UIViewController) {
        let aler = UIAlertController.init(title: "disconnect", message: "disconnect", preferredStyle: .alert)
        let actionOK = UIAlertAction.init(title: "OK", style: .default) { (alertAction) in
            CommonVariable.isDisConnect = true
            let aler = UIAlertController.init(title: "", message: "", preferredStyle: .alert)
            let actionCancel = UIAlertAction.init(title: "", style: .cancel, handler: nil)
            aler.addAction(actionCancel)
            supperView.present(aler, animated: true, completion: nil)
        }
        let actionCancel = UIAlertAction.init(title: "NO", style: .cancel, handler: nil)
        aler.addAction(actionOK)
        aler.addAction(actionCancel)
        supperView.present(aler, animated: true, completion: nil)
    }
}
