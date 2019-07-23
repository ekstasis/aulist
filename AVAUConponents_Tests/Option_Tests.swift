//
//  Option_Tests.swift
//  AVAUConponents_Tests
//
//  Created by James Baxter on 7/19/19.
//  Copyright © 2019 Spacebug Industries. All rights reserved.
//

import XCTest

class Option_Tests: XCTestCase {

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
        XCTAssert(goodOptions1.options[0].rawValue == "no_apple")
        XCTAssert(goodOptions1.arguments.count == 3)
        XCTAssert(goodOptions1.arguments[0] == "appl")
        XCTAssert(goodOptions1.arguments[1] == "0")
        XCTAssert(goodOptions1.arguments[2] == "0")
    }
    
    func testMaxOptionLength() {
        XCTAssertTrue(Option.maxOptionLength == 8)
    }
    
    func testIsSet() {
        let options = Options(cliArgs: ["--no_apple", "--no_views"])!
        XCTAssertTrue(options.isSet(option: .no_apple))
        XCTAssertTrue(options.isSet(option: .no_views))
        XCTAssertFalse(options.isSet(option: .no_ints))
    }
    
    func testNameAndDesc() {
        let tests: [(String, String)] = [ ("no_apple", Option.no_apple.rawValue),
                                          ("no_ints", Option.no_ints.rawValue),
                                          ("Don't show AUs of type 'auvw'", Option.no_views.description) ]
        tests.forEach {
            XCTAssertEqual($0.0, $0.1)
        }
    }
}
