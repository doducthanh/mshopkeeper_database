//
//  Database.swift
//  MShopKeeper
//
//  Created by ddthanh on 3/9/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import Foundation
import SQLite

public class Database {
    
    static let share = Database()
    public let connection: Connection?
    public let databaseName = "mshopkeeper.sqlite"
    
    private init () {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first as String!
        do {
            connection = try Connection("\(path!)/(databaseName)")
        } catch {
            connection = nil
            print("can't connect database")
        }
    }
    
}
