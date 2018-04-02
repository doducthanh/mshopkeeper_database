//
//  ModelImage_SQLite.swift
//  MShopKeeper
//
//  Created by ddthanh on 3/23/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import Foundation
import SQLite

class ModelImage_SQLite {
//    khai báo thuộc tính và bảng
    private let tblImage = Table.init("tblImage")
    private let modelID = Expression<Int>("modelID")
    private let data = Expression<Data>("data")
    static let share = ModelImage_SQLite()
    
//    hàm khởi tạo
    private init(){
        do {
            if let connection = Database.share.connection {
                try connection.run(tblImage.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (table) in
                    table.column(self.modelID, primaryKey: true)
                    table.column(self.data)
                }))
            }
        } catch  {
            
        }
    }
    
    /// hàm insert dữ liệu vào bảng
    ///
    /// - Parameters:
    ///   - modelID: mã modelID
    ///   - data: data của avatar
    /// - Returns: Int64
    func insert(modelID: Int, data: Data) -> Int64? {
        do {
            let insert = tblImage.insert(self.modelID <- modelID,
                                         self.data <- data)
            let insertID = try Database.share.connection!.run(insert)
            print("insert image success")
            return insertID
        } catch {
            print("insert image error")
            return nil
        }
    }
    
    /// hàm lấy ra tất cả dữ liệu trong bảng
    ///
    /// - Returns: dạng mảng
    func getAllRow() -> AnySequence<Row>? {
        do {
            return try Database.share.connection!.prepare(tblImage)
        } catch  {
            return nil
        }
    }
    
    
    /// hàm lấy ra data image
    ///
    /// - Parameter key: modelID
    /// - Returns: data ảnh
    func getDataForKey(key: Int) -> Data? {
        do {
            let query = (self.modelID == key)
            let anySequene = try Database.share.connection!.prepare(self.tblImage.filter(query))
            let row = anySequene.first(where: { (rows) -> Bool in
                return true
            })
            return row![self.data]
        } catch  {
            return nil
        }
    }
    
    /// hàm update bản ghi
    func updateRow() -> Bool {
        return true
    }
    
    /// hàm xoá dữ liệu local
    func deleteAllRow() {
        do {
            if let connect = Database.share.connection {
                try connect.run(self.tblImage.delete())
            }
        } catch {
            return
        }
    }
}
