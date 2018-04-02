//
//  Model_SQLite.swift
//  MShopKeeper
//
//  Created by ddthanh on 3/20/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import Foundation
import SQLite
import Kingfisher
import Alamofire

public class Model_SQLite {
//    khai bao thuoc tinh
    private let tblModel = Table.init("tblModel")
    
    private let modelID = Expression<Int>("modelID")
    private let shopID = Expression<Int>("shopID")
    private let modelName = Expression<String>("modelName")
    private let modelType = Expression<Int>("modelType")
    private let decription = Expression<String>("decription")
    private let pictureLink = Expression<String>("pictureLink")
    private let unitPrice = Expression<Int>("unitPrice")
    private let dateOfEntry = Expression<String>("dateOfEntry")
    private let isPromotion = Expression<Bool>("isPromotion")
    private let percentPromotion = Expression<Double>("percentPromotion")
    private let saleCount = Expression<Int>("saleCount")
//    private let modelAvatar = Expression<Data>("modelAvatar")
    
    static let share = Model_SQLite()
    //hàm tạo bảng
    private init() {
        do {
            if let connect = Database.share.connection {
                try connect.run(tblModel.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (table) in
                    table.column(self.modelID, primaryKey: true)
                    table.column(self.shopID)
                    table.column(self.modelName)
                    table.column(self.modelType)
                    table.column(self.decription)
                    table.column(self.pictureLink)
                    table.column(self.unitPrice)
                    table.column(self.dateOfEntry)
                    table.column(self.isPromotion)
                    table.column(self.percentPromotion)
                    table.column(self.saleCount)
//                    table.column(self.modelAvatar)
                }))
                print("create table model success")
            } else {
                print("create table model error")
            }
        } catch {
            print(error)
        }
    }
    
    /// thêm row vào bàng
    ///
    /// - Parameter model: Model
    /// - Returns: Int64
    func insert(model: Model) -> Int64? {
        do {
            //var data: Data = Data()
            let insert = tblModel.insert(self.modelID <- model.modelID,
                                         self.modelName <- model.modelName,
                                         self.shopID <- model.shopID,
                                         self.modelType <- model.modelType,
                                         self.decription <- model.decription,
                                         self.pictureLink <- model.pictureLink,
                                         self.unitPrice <- model.unitPrice,
                                         self.dateOfEntry <- model.dateOfEntry,
                                         self.isPromotion <- model.isPromtion,
                                         self.percentPromotion <- model.percentPromtion,
                                         self.saleCount <- model.saleCount)
            let insertID = try Database.share.connection!.run(insert)
            print("insert model success")
            return insertID
        } catch {
            print("insert error")
            return nil
        }
    }
    
    /// lấy ra các bản ghi trong bảng
    ///
    /// - Returns: mảng row
    func getAllRow() -> AnySequence<Row>? {
        do {
            return try Database.share.connection!.prepare(tblModel)
        } catch  {
            return nil
        }
    }
    
    /// lấy về dữ liệu model theo key
    ///
    /// - Parameter key: modelName
    /// - Returns: mảng row
    func queryDataForKey(key: String) -> AnySequence<Row>? {
        //var arrayModel: [Model]
        do {
            let query = (modelName.like("%\(key)%"))
            return try Database.share.connection?.prepare(self.tblModel.filter(query))
        } catch {
            print("query data for key error")
            return nil
        }
    }
    
    /// update dữ liệu trên bảng
    ///
    /// - Returns: bool
    func updateRow() -> Bool {
        return true
    }
    

    /// show dữ liệu 1 hàng
    ///
    /// - Parameter department: row
    func toString(department: Row) {
        print("modelID:\(department[self.modelID]), modelName:\(department[self.modelName]), unitPrice:\(department[self.unitPrice])")
    }
    
    /// xoá dữ liệu bảng
    func deleteAllRow() {
        do {
            if let connect = Database.share.connection {
                try connect.run(self.tblModel.delete())
            }
        } catch {
            print("delete error")
            return
        }
    }
    
}
