//
//  Option_Tests.swift
//  AVAUConponents_Tests
//
//  Created by James Baxter on 7/19/19.
//  Copyright © 2019 Spacebug Industries. All rights reserved.
//

import XCTest

class Option_Tests: XCTestCase {
    
    //    override func setUp() {
    //        // Put setup code here. This method is called before the invocation of each test method in the class.
    //    }
    //
    //    override func tearDown() {
    //        // Put teardown code here. This method is called after the invocation of each test method in the class.
    //    }
    
    func testBadOptions() {
        let bad1 = ["--no_apple", "--foo", "foo"]
        let badOptions1 = Options(cliArgs: bad1)
        XCTAssertNil(badOptions1)
    }
    
    func testGoodOptions() {
        let good1 = ["--no_apple", "appl"]
        let goodOptions1 = Options(cliArgs: good1)!
        XCTAssertNotNil(goodOptions1)
        XCTAssert(goodOptions1.options.count == 1)
        XCTAssert(goodOptions1.options[0].name == "no_apple")
        XCTAssert(goodOptions1.arguments.count == 3)
        XCTAssert(goodOptions1.arguments[0] == "appl")
        XCTAssert(goodOptions1.arguments[1] == "0")
        XCTAssert(goodOptions1.arguments[2] == "0")
    }
    
    func testMaxOptionLength() {
        XCTAssertTrue(Options.maxOptionLength == 10)
    }
}
