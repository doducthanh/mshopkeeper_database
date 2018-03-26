//
//  ItemModel.swift
//  MShopKeeper
//
//  Created by ddthanh on 3/9/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import Foundation
import UIKit

// lớp thực thiên các thao tác xử lí đến Item.
class ItemModel {
    
    var arrayItem = [Item]()
    var color = ""
    var size = ""
    
    func requestAllData() {
        
    }
    
    func getPrice(color: String, size: String) -> String {
        for item in arrayItem {
            if item.color == color && item.size == size {
                return (item.unitPrice.description + Constant.Currency_Unit)
            }
        }
        return ""
    }
    
    func getAllAddress(color: String, size: String) -> [String] {
        var set = Set<String>()
        for item in arrayItem {
            if item.color == color && item.size == size {
                set.insert(item.addressShop)
            }
        }
        return Array(set)
    }
    
    func getSKUCode(color: String, size: String) -> String {
        for item in arrayItem {
            if item.color == color && item.size == size {
                return item.SKUCode
            }
        }
        return ""
    }
    
    func addViewAddress(array: [String], frame: CGRect) -> UIView {
        let view = UIView.init(frame: frame)
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: Int(frame.width), height: 30))
        label.text = "Địa chỉ"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        view.addSubview(label)
        
        for index in 0..<array.count {
            let label = UILabel.init()
            label.frame = CGRect.init(x: 0, y: 40 + index * 30, width: Int(frame.width), height: 30)
            label.text = array[index]
            view.addSubview(label)
        }
        return view
    }
    
}
