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
//    khai báo thuộc tính
    var arrayItem = [Item]()
    var color = ""
    var size = ""
    
    var delegate: ItemModelDelegate!
    var switchAddress: UISegmentedControl!
    
    func requestAllData() {
        
    }
   
    /// hàm dùng để trả về giá của sản phẩm
    ///
    /// - Parameters:
    ///   - color: màu sp lựa chọn
    ///   - size: kích thước sp lựa chọn
    /// - Returns: giá sản phẩm
    func getPrice(color: String, size: String) -> String {
        for item in arrayItem {
            if item.color == color && item.size == size {
                return (item.unitPrice.description + Constant.Currency_Unit)
            }
        }
        return ""
    }
    
    /// hàm trả về địa chỉ tất cả các cửa hàng có sp
    ///
    /// - Parameters:
    ///   - color: màu sp lựa chọn
    ///   - size: kích cỡ sp lưa chọn
    /// - Returns: danh sách dịa chỉ các cửa hàng
    func getAllAddress(color: String, size: String) -> [String] {
        var set = Set<String>()
        for item in arrayItem {
            if item.color == color && item.size == size {
                set.insert(item.addressShop)
            }
        }
        return Array(set)
    }
    
    /// hàm trả về mã sku của sp
    ///
    /// - Parameters:
    ///   - color: màu sắc lựa chọn
    ///   - size: kích cỡ lựa chọn
    /// - Returns: mã SKU
    func getSKUCode(color: String, size: String) -> String {
        for item in arrayItem {
            if item.color == color && item.size == size {
                return item.SKUCode
            }
        }
        return ""
    }
    
    /// hàm trả về số lượng sản phẩm còn lại trong của hàng hiên tại
    ///
    /// - Returns: tuple (tên của hàng, số lượng)
    func getCurrentShopCountItem() -> [(String, Int)] {
        var count: Int = 0
        var addressShop = ""
        let shopID = UserDefaults.standard.value(forKey: "shopID") as! Int
        for item in arrayItem {
            if item.shopID == shopID {
                count += 1
                addressShop = item.addressShop
            }
        }
        return [(addressShop, count)]
    }
    
    /// hàm trả về mảng sản phẩm có cùng size, color, mà modelID
    ///
    /// - Parameters:
    ///   - color: màu được chọn
    ///   - size: size được chọn
    /// - Returns: mảng item
    func getArrayItemSelect(color: String, size: String) -> [Item] {
        var array = [Item]()
        for item in arrayItem {
            if item.color == color && item.size == size {
                array.append(item)
            }
        }
        return array
    }
   
    /// hàm trả về danh sách cửa hàng và số lượng item được chọn có trong cửa hàng đó
    ///
    /// - Parameter arrayItem: mảng item có cùng size và color
    /// - Returns: mảng kết quả
    func getOtherShopCountItem(arrayItems: [Item]) -> [(String, Int)] {
        var addressShop = [(String, Int)]()
        let shopID = UserDefaults.standard.value(forKey: "shopID") as! Int
        var setAddress = Set<Int>()
        for item in arrayItems {
            setAddress.insert(item.shopID)
        }
        for item in setAddress {
            let otherShopID = item
            if otherShopID != shopID {
                var nCount = 0
                var nAddShop = ""
                for nItem in arrayItems {
                    if nItem.shopID == otherShopID {
                        nCount += 1
                        nAddShop = nItem.addressShop
                    }
                }
                addressShop.append((nAddShop, nCount))
            }
        }
        return addressShop
    }
    
    /// hàm thêm view danh sách cửa hàng
    ///
    /// - Parameters:
    ///   - array: danh sách tên địa chỉ cửa hàng
    ///   - frame: frame vẽ view
    /// - Returns: view địa chỉ
    func addViewAddress(array: [Item], frame: CGRect) -> UIView {
        let view = UIView.init(frame: frame)
        
        switchAddress = UISegmentedControl.init()
        switchAddress.frame = CGRect.init(x: frame.width/2 - 120, y: 0, width: 240, height: 40)
        switchAddress.insertSegment(withTitle: "Trong kho cửa hàng", at: 0, animated: true)
        switchAddress.insertSegment(withTitle: "Cửa hàng khác", at: 1, animated: true)
        switchAddress.selectedSegmentIndex = 0
        switchAddress.addTarget(self, action: #selector(onClickSegment), for: .valueChanged)
        view.addSubview(switchAddress)
        
        if CommonVariable.isSelectShopCurrent {
            let arr = self.getCurrentShopCountItem()
            if arr[0].1 == 0 {
                CommonVariable.numberRowAddress = 0
                return view
            }
            for index in 0..<arr.count {
                let frame: CGRect = CGRect.init(x: 0, y: 50 + index * 40, width: Int(frame.width), height: 40)
                let lbAddress = ViewAddress.init(frame: frame)
                lbAddress.initView(address: arr[index].0, count: arr[index].1)
                view.addSubview(lbAddress)
            }
            CommonVariable.numberRowAddress = 1
        } else {
            let arr = self.getOtherShopCountItem(arrayItems: array)
            for index in 0..<arr.count {
                let frame: CGRect = CGRect.init(x: 0, y: 50 + index * 40, width: Int(frame.width), height: 40)
                let lbAddress = ViewAddress.init(frame: frame)
                lbAddress.initView(address: arr[index].0, count: arr[index].1)
                view.addSubview(lbAddress)
            }
            CommonVariable.numberRowAddress = arr.count
        }
        return view
    }
    
    
    @objc func onClickSegment() {
        self.delegate.segmentChangeValue(index: switchAddress.selectedSegmentIndex)
        if switchAddress.selectedSegmentIndex == 0 {
            CommonVariable.isSelectShopCurrent = true
        } else {
            CommonVariable.isSelectShopCurrent = false
        }
    }
}

protocol ItemModelDelegate {
    func segmentChangeValue(index: Int)
}
