//
//  Item_SQLite.swift
//  MShopKeeper
//
//  Created by ddthanh on 3/21/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import Foundation
import SQLite

class Item_SQLite {
//    khai báo các thuộc tính.
    private let tblItem = Table.init("tblItem")
    private let itemID = Expression<Int>("itemID")
    private var modelID = Expression<Int>("modelID")
    private let SKUCode = Expression<String>("SKUCode")
    private let decription = Expression<String>("decription")
    private let unitPrice = Expression<Int>("unitPrice")
    private let isPromotion = Expression<Bool>("isPromotion")
    private let percentPromotion = Expression<Double>("percentPromotion")
    private let color = Expression<String>("color")
    private let size = Expression<String>("size")
    private let addressShop = Expression<String>("addressShop")
    private let addressStock = Expression<String>("addressStock")
    private let barCode = Expression<String>("barCode")
    static let share = Item_SQLite()
    
//    khởi tạo bảng
    private init() {
        do {
            try Database.share.connection?.run(tblItem.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (table) in
                table.column(self.itemID, primaryKey: true)
                table.column(self.modelID)
                table.column(self.SKUCode)
                table.column(self.decription)
                table.column(self.unitPrice)
//                table.column(self.dateOfEntry)
                table.column(self.isPromotion)
                table.column(self.percentPromotion)
                table.column(self.color)
                table.column(self.size)
                table.column(self.addressShop)
                table.column(self.addressStock)
                table.column(self.barCode)
            }))
        } catch  {
            print(error)
        }
    }
    
    /// insert 1 row vào bảng item
    ///
    /// - Parameter item: Item
    /// - Returns: Int64
    func insertRow(item: Item) -> Int64? {
        do{
            let insert = self.tblItem.insert(self.itemID <- item.itemId,
                                              self.modelID <- item.modelID,
                                              self.SKUCode <- item.SKUCode,
                                              self.decription <- item.decription,
                                              self.unitPrice <- item.unitPrice,
                                              self.isPromotion <- item.isPromotion,
                                              self.percentPromotion <- item.percentPromotion,
                                              self.color <- item.color,
                                              self.size <- item.size,
                                              self.addressShop <- item.addressShop,
                                              self.addressStock <- item.addressStock,
                                              self.barCode <- item.barCode
                                              )
            let inserId =  try Database.share.connection?.run(insert)
            print("insert row for tblItem sucess")
            return inserId
        } catch {
            return nil
        }
    }
    

    /// trả về các bản ghi của bảng
    ///
    /// - Returns: dạng mảng
    func getAllRow() -> AnySequence<Row>? {
        do {
            return try Database.share.connection?.prepare(self.tblItem)
        } catch {
            print("get all row error")
            return nil
        }
    }
    
    /// hàm query dữ liệu theo modelID
    ///
    /// - Parameter key: modelID
    /// - Returns: dạng mảng
    func queryDataForKey(key: Int) -> AnySequence<Row>? {
        //var arrayModel: [Model]
        do {
            let query = (self.modelID == key)
            return try Database.share.connection?.prepare(self.tblItem.filter(query))
        } catch {
            print("query data for key error")
            return nil
        }
    }
   
    /// hàm update dữ liệu 1 bản ghi trong bảng
    ///
    /// - Returns: true/false
    func updateRow() -> Bool {
        return true
    }
    
    
    /// show dữ liệu bảng
    ///
    /// - Parameter department: row
    func toString(department: Row) {
        print("modelID:\(department[self.itemID]), modelName:\(department[self.SKUCode]), unitPrice:\(department[self.unitPrice])")
    }
    
   
    /// hàm xoá dữ liệu trên bảng.
    func deleteAllRow() {
        do {
            if let connect = Database.share.connection {
                try connect.run(self.tblItem.delete())
            }
        } catch {
            print("delete error")
            return
        }
    }
}
