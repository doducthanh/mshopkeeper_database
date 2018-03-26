//
//  Address_SQLite.swift
//  MShopKeeper
//
//  Created by ddthanh on 3/9/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import Foundation
import SQLite

class Address_SQLite {
    // tạo các thuộc tính của bảng
    private let zipcode = Expression<Int>("zipcode")
    private let country = Expression<String>("country")
    private let provinceOrCity = Expression<String>("provinceOrCity")
    private let district = Expression<String>("district")
    private let street = Expression<String>("street")
    
    private let tblAddress = Table("tblAddress")
    
    // hàm khởi tạo bảng
    init() {
        do {
            if let connect = Database.share.connection {
                //tao bang
                try connect.run(tblAddress.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (table) in
                    table.column(self.zipcode, primaryKey: true)
                    table.column(self.country)
                    table.column(self.provinceOrCity)
                    table.column(self.district)
                    table.column(self.street)
                    print("create tblAddress succses")
                }))
            } else{
                print("create tblAddress error")
            }
        } catch {
            print(error)
        }
    }
    
    // hàm insert 1 row vào bảng
    func insert(zipcode: Int, country: String, city: String, district: String, street: String) -> Int64? {
        do {
            let insert = tblAddress.insert(self.zipcode <- zipcode,
            self.country <- country,
            self.provinceOrCity <- city,
            self.district <- district,
            self.street <- street)
            
            let inserId =  try Database.share.connection?.run(insert)
            print("insert row for tblAddress sucess")
            return inserId
        } catch {
            print("insert row for tblAddress error")
            return nil
        }
    }
    
    // hàm update 1 row trong bảng
    func update(zipcode: Int, country: String?, city: String?, street: String?) -> Bool {
        if Database.share.connection == nil {
            return false
        }
        do {
            let filter = self.tblAddress.filter(self.zipcode == zipcode)
            var setters = [SQLite.Setter]()
            if country != nil {
                setters.append(self.country <- country!)
            }
            if city != nil {
                setters.append(self.provinceOrCity <- city!)
            }
            if street != nil {
                setters.append(self.street <- street!)
            }
            
            if setters.count == 0 {
                return false
            }
            let update = filter.update(setters)
            if try Database.share.connection!.run(update) <= 0 {
                return false
            }
            return true
        } catch {
            print("update row for tblAddress error")
            return false
        }
    }
    
    // hàm lấy ra tất cả các bản ghi
    func getAllRecord() -> AnySequence<Row>? {
        do {
            return try Database.share.connection?.prepare(self.tblAddress)
        } catch {
            print("get all record tblAddress error")
            return nil
        }
    }
    
    func toString() {
        print("zipcode:\(self.zipcode), country:\(self.country), city:\(self.provinceOrCity), district:\(self.district), street:\(self.street)")
    }
}
