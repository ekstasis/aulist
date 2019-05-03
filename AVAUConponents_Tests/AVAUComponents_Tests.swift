//
//  AVAUConponents_Tests.swift
//  AVAUConponents_Tests
//
//  Created by James Baxter on 5/2/19.
//  Copyright © 2019 Spacebug Industries. All rights reserved.
//

import XCTest

class AVAUComponents_Tests: XCTestCase {
   
   // Test basic functionality, which happens in init(manu, type, subtype)
   func testInit()
   {
      // All AUs
      var comps = AVAUComponents()!
      XCTAssert(comps.manu == 0 && comps.componentType == 0 && comps.subtype == 0)
      XCTAssert(comps.components.count > 10)
      
      // All Apple AUs
      comps = AVAUComponents(manu: "appl")!
      let appl = 1634758764
      XCTAssert(comps.manu == appl && comps.componentType == 0 && comps.subtype == 0)
      XCTAssert(comps.components.count > 10)
      let nonAppleComponents = comps.components.filter {
         $0.audioComponentDescription.componentManufacturer != appl
      }
      XCTAssert(nonAppleComponents.count == 0)
      
      // Apple: AUDynamicsProcessor (appl aufx dcmp)
      comps = AVAUComponents(manu: "appl", componentType: "aufx", subtype: "dcmp")!
      let comp = comps.components[0]
      XCTAssert(comps.components.count == 1)
      XCTAssert(comp.manufacturerName == "Apple")
      XCTAssert(comp.typeName == "Effect")
      XCTAssert(comp.name == "AUDynamicsProcessor")
      XCTAssert(comps.manu == appl && comps.componentType == "aufx".osType() &&
         comps.subtype == "dcmp".osType())
      
      //
      XCTAssert(AVAUComponents(manu: "SBI", componentType: "aufx") == nil)
   }
   
   // Test extension of String
   func test_osType()
   {
      let codes: [String: OSType?] = [
         "": nil, "a": nil, "ab": nil, "abc": nil, "abcde":nil,
         "test": 1952805748, "appl": 1634758764
      ]
      for (string, number) in codes {
         XCTAssert(string.osType() == number)
      }
   }
   
   // Test extesnsion of OSType (aka UInt32 aka FourCharCode)
   func test_osTypeToString()
   {
      let codes: [OSType: String] = [
         1952805748: "test", 1634758764: "appl"
      ]
      for (number, string) in codes {
         XCTAssert(number.string() == string)
      }
   }
   
}

//override func setUp() {
//   // Put setup code here. This method is called before the invocation of each test method in the class.
//}
//
//override func tearDown() {
//   // Put teardown code here. This method is called after the invocation of each test method in the class.
//}
//
//func testPerformanceExample() {
//   // This is an example of a performance test case.
//   self.measure {
//      // Put the code you want to measure the time of here.
//   }
//}
