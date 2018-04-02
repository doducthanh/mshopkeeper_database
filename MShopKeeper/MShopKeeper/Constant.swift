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
        let aler = UIAlertController.init(title: NSLocalizedString(MatchKeyLocalizable.kDisInternet, comment: ""), message: NSLocalizedString(MatchKeyLocalizable.kToastDisInternet, comment: ""), preferredStyle: .alert)
        let actionOK = UIAlertAction.init(title: NSLocalizedString(MatchKeyLocalizable.kTextOK, comment:    ""), style: .default) { (alertAction) in
            CommonVariable.isDisConnect = true
            let aler = UIAlertController.init(title: "", message: NSLocalizedString(MatchKeyLocalizable.kToastSuccesDisInter, comment: ""), preferredStyle: .alert)
            let actionCancel = UIAlertAction.init(title: NSLocalizedString(MatchKeyLocalizable.kTextYes, comment: ""), style: .cancel, handler: nil)
            aler.addAction(actionCancel)
            supperView.present(aler, animated: true, completion: nil)
        }
        let actionCancel = UIAlertAction.init(title: NSLocalizedString(MatchKeyLocalizable.kTextNo, comment: ""), style: .cancel, handler: nil)
        aler.addAction(actionOK)
        aler.addAction(actionCancel)
        supperView.present(aler, animated: true, completion: nil)
    }
}
