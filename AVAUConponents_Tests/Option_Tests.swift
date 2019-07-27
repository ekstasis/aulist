//
//  Option_Tests.swift
//  AVAUConponents_Tests
//
//  Created by James Baxter on 7/19/19.
//  Copyright © 2019 Spacebug Industries. All rights reserved.
//

import XCTest

class Option_Tests: XCTestCase {
    
    lazy var allAUs = AVAUComponents(options: nil)
    lazy var appleAUs = AVAUComponents(options: Options(cliArgs: ["appl"]))

    func testBadOptions() {
        let bad1 = ["--no_system", "--foo", "foo"]
        let badOptions1 = Options(cliArgs: bad1)
        XCTAssertNil(badOptions1)
    }
    
    func testGoodOptions() {
        let good1 = ["--no_system", "ABCD"]
        let goodOptions1 = Options(cliArgs: good1)!
        XCTAssertNotNil(goodOptions1)
        XCTAssert(goodOptions1.options.count == 1)
        XCTAssert(goodOptions1.options[0].rawValue == "no_system")
        XCTAssert(goodOptions1.arguments.count == 3)
        XCTAssert(goodOptions1.arguments[0] == "ABCD")
        XCTAssert(goodOptions1.arguments[1] == "0")
        XCTAssert(goodOptions1.arguments[2] == "0")
    }
    
    func testMaxOptionLength() {
        XCTAssertTrue(Option.maxOptionLength == 9)
    }
    
    func testIsSet() {
        let options = Options(cliArgs: ["--no_system", "--no_views"])!
        XCTAssertTrue(options.isSet(option: .no_system))
        XCTAssertTrue(options.isSet(option: .no_views))
        XCTAssertFalse(options.isSet(option: .no_ints))
    }
    
    func testNameAndDesc() {
        let tests: [(String, String)] = [ ("no_system", Option.no_system.rawValue),
                                          ("no_ints", Option.no_ints.rawValue),
                                          ("Don't show AUs of type 'auvw'", Option.no_views.description) ]
        tests.forEach {
            XCTAssertEqual($0.0, $0.1)
        }
    }
    
    func testNosystem() {
        let allCount = allAUs.count
        // check if we're not just getting 0 because of bug, assumes >50 apple built-ins
        XCTAssert(allAUs.count > 50)
        let appleCount = appleAUs.count
        let nosystem = Options(cliArgs: ["--no_system"])
        let third_party = AVAUComponents(options: nosystem!)
        let thirdCount = third_party.count
        let sys_aus = AVAUComponents(options: Options(cliArgs: ["sys", "0", "0"]))
        let sysCount = sys_aus.count
        XCTAssert(allCount == sysCount + appleCount + thirdCount)
    }
    
    func testNoViews() {
        // check if we're not just getting 0 because of bug, assumes >50 apple built-ins
        XCTAssert(allAUs.count > 50)
        let noViews = AVAUComponents(options: Options(cliArgs: ["--no_views"]))
        let onlyViews = AVAUComponents(options: Options(cliArgs: ["0", "auvw"]))
        XCTAssert(allAUs.count == noViews.count + onlyViews.count)

//        let appleonly = Options(cliArgs: ["appl"])
//        let third_party = AVAUComponents(options: noapple!)
//        let built_in = AVAUComponents(options: appleonly!)
//        let all_AUs = AVAUComponents(options: nil)
        
    }
}
