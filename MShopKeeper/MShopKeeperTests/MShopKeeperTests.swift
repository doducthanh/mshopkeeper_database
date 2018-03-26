//
//  MShopKeeperTests.swift
//  MShopKeeperTests
//
//  Created by ddthanh on 1/18/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import XCTest
@testable import MShopKeeper
@testable import Alamofire
@testable import SQLite

class MShopKeeperTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testSuccessLogin() {
        let userMode = UserModel()
        userMode.requestLogin(companyCode: "ddthanh", username: "liemqv", password: "123456") { (value, error) in
            XCTAssertNotNil(value)
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let values = value {
                if values as! Decimal == 200 {
                    // 2
                    
                } else {
                    XCTFail("Status code: \(values)")
                }
            }
        }
    }
    
    func testErorrInfor() {
        let userMode = UserModel()
        var result: Int = 0
        userMode.requestLogin(companyCode: "ddthanh", username: "", password: "") { (status, error) in
            result = status as! Int
        }
        XCTAssertNotEqual(result, 200)
    }
    
    func testErorrPass() {
        let userMode = UserModel()
        userMode.requestLogin(companyCode: "ddthanh", username: "liemqv", password: "") { (status, erorr) in
            XCTAssertNotEqual(status as! Int, 200)
        }
    }
    
    func testErorrCompanyCode() {
        let userMode = UserModel()
        userMode.requestLogin(companyCode: "liemqv", username: "liemqv", password: "") { (status, erorr) in
            XCTAssertNotEqual(status as! Int, 200)
        }
    }
    
}
