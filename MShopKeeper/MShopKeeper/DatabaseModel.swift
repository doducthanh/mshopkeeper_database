//
//  DatabaseModel.swift
//  MShopKeeper
//
//  Created by ddthanh on 3/21/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import Foundation
import SQLite
import Alamofire
/// class thực hiên các thao tác liên quan đến database local.
class DatabaseModel {
    
    static let share = DatabaseModel()

    /// hàm insert các bản ghi cho bảng model
    ///
    /// - Parameter arrayModels: mảng dữ liệu model
    func insertRowModel(arrayModels: [Model]) {
//        xoá các dữ liệu cũ
        Model_SQLite.share.deleteAllRow()
        for model in arrayModels {
           _ = Model_SQLite.share.insert(model: model)
//             luu lai anh vao local
            DispatchQueue.init(label: "save avatar picture").async {
                Alamofire.request(model.pictureLink)
                    .responseData(completionHandler: { (responseData) in
                        if responseData.data != nil {
                            _ = ModelImage_SQLite.share.insert(modelID: model.modelID, data: responseData.data!)
                        }
                    })
            }
        }
    }
    
    /// hàm thêm các bản ghi cho bảng Item
    ///
    /// - Parameter arrayItems: mảng dữ liệu item cân lưu
    func insertRowItem(arrayItems: [Item] ) {
//        xoá dữ liệu cũ
        Item_SQLite.share.deleteAllRow()
        for item in arrayItems {
            _ = Item_SQLite.share.insertRow(item: item)
        }
    }
    
    /// hàm lấy ra tất cả dữ liệu của bảng model.
    ///
    /// - Returns: mảng các model
    func getAllModelRecords() -> [Model] {

        var arrayModel = [Model]()
        if let models: AnySequence<Row> = Model_SQLite.share.getAllRow() {
            _ = models.map{ row in
                let model = Model()
                model.modelID = row[Expression<Int>("modelID")]
                model.modelName = row[Expression<String>("modelName")]
                model.shopID = row[Expression<Int>("shopID")]
                model.decription = row[Expression<String>("decription")]
                model.unitPrice = row[Expression<Int>("unitPrice")]
                model.modelType = row[Expression<Int>("modelType")]
                model.isPromtion = row[Expression<Bool>("isPromotion")]
                model.dateOfEntry = row[Expression<String>("dateOfEntry")]
                model.pictureLink = row[Expression<String>("pictureLink")]
                model.percentPromtion = row[Expression<Double>("percentPromotion")]
                model.saleCount = row[Expression<Int>("saleCount")]
                model.dataImage = ModelImage_SQLite.share.getDataForKey(key: model.modelID)
                arrayModel.append(model)
            }
        }
        return arrayModel
    }
    
    /// hàm lấy về các model theo tên
    ///
    /// - Parameter key: tên model
    /// - Returns: mảng các model
    func getAllModelRecordsForKey(key: String) -> [Model] {

        var arrayModel = [Model]()
        if let models: AnySequence<Row> = Model_SQLite.share.queryDataForKey(key: key) {
            _ = models.map{ row in
//                parse giá trị row thành object model
                let model = Model()
                model.modelID = row[Expression<Int>("modelID")]
                model.modelName = row[Expression<String>("modelName")]
                model.shopID = row[Expression<Int>("shopID")]
                model.decription = row[Expression<String>("decription")]
                model.unitPrice = row[Expression<Int>("unitPrice")]
                model.modelType = row[Expression<Int>("modelType")]
                model.isPromtion = row[Expression<Bool>("isPromotion")]
                model.dateOfEntry = row[Expression<String>("dateOfEntry")]
                model.pictureLink = row[Expression<String>("pictureLink")]
                model.percentPromtion = row[Expression<Double>("percentPromotion")]
                model.saleCount = row[Expression<Int>("saleCount")]
                model.dataImage = ModelImage_SQLite.share.getDataForKey(key: model.modelID)
                arrayModel.append(model)
            }
        }
        return arrayModel
    }
    
    /// hàm lấy về tất cả các model
    ///
    /// - Returns: mảng model
    func getModelStock() -> [Model] {
        var arrayModel = [Model]()
        if let models: AnySequence<Row> = Model_SQLite.share.getAllRow() {
            _ = models.map{ row in
                let model = Model()
                model.modelID = row[Expression<Int>("modelID")]
                model.modelName = row[Expression<String>("modelName")]
                model.shopID = row[Expression<Int>("shopID")]
                model.decription = row[Expression<String>("decription")]
                model.unitPrice = row[Expression<Int>("unitPrice")]
                model.modelType = row[Expression<Int>("modelType")]
                model.isPromtion = row[Expression<Bool>("isPromotion")]
                model.dateOfEntry = row[Expression<String>("dateOfEntry")]
                model.pictureLink = row[Expression<String>("pictureLink")]
                model.percentPromtion = row[Expression<Double>("percentPromotion")]
                model.saleCount = row[Expression<Int>("saleCount")]
                model.dataImage = ModelImage_SQLite.share.getDataForKey(key: model.modelID)
                arrayModel.append(model)
            }
        }
        return arrayModel
    }
    
    /// hàm lấy về mảng các item của mẫu
    ///
    /// - Parameter modelID: mã id của mẫu sản phẩm
    /// - Returns: mảng color,mảng size mà mảng item
    func getAllItemRecords(modelID: Int) -> (arrayColor: [String], arraySize: [String], arrayItem: [Item]){
        var arrayModel = [Item]()
        var arrayColor = Set<String>()
        var arraySize = Set<String>()
        if let models: AnySequence<Row> = Item_SQLite.share.queryDataForKey(key: modelID) {
            _ = models.map{ row in
                let model = Item()
                model.itemId = row[Expression<Int>("itemID")]
                model.modelID = row[Expression<Int>("modelID")]
                model.decription = row[Expression<String>("decription")]
                model.unitPrice = row[Expression<Int>("unitPrice")]
                model.isPromotion = row[Expression<Bool>("isPromotion")]
//                model.isDisplayPrice = row[Expression<Bool>("isDisplayPrice")]
                model.color = row[Expression<String>("color")]
                model.size = row[Expression<String>("size")]
                arraySize.insert(model.size)
                arrayColor.insert(model.color)
                model.SKUCode = row[Expression<String>("SKUCode")]
                model.barCode = row[Expression<String>("barCode")]
                model.addressShop = row[Expression<String>("addressShop")]
                model.percentPromotion = row[Expression<Double>("percentPromotion")]
                arrayModel.append(model)
            }
        }
        return (arrayColor: Array(arrayColor), arraySize: Array(arraySize), arrayItem: arrayModel)
    }
}
