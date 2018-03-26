//
//  ForgetPassTest.swift
//  MShopKeeperTests
//
//  Created by ddthanh on 3/14/18.
//  Copyright © 2018 ddthanh. All rights reserved.
//

import XCTest
@testable import MShopKeeper

class ForgetPassTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testText() {
        let mt = ManageInputModel()
        let text = mt.checkValidateText(text: "adcd")
        XCTAssertEqual(text, ErorrValidate.textShort)
    }
    
    func testTextValid() {
        let mt = ManageInputModel()
        XCTAssertEqual(mt.checkValidateText(text: "123addg"), ErorrValidate.invalid)
    }
    
    func testComparePass() {
        let mt = ManageInputModel()
        let result = mt.compairPassword(pass: "123456", rePass: "123456")
        XCTAssertTrue(result)
        
        let result2 = mt.compairPassword(pass: "1213", rePass: "123456")
        XCTAssertFalse(result2)
    }
}
