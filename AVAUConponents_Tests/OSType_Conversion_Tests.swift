//
//  OSType_Conversion_Tests.swift
//  AVAUConponents_Tests
//
//  Created by James Baxter on 7/6/19.
//  Copyright © 2019 Spacebug Industries. All rights reserved.
//

import XCTest

class OSType_Conversion_Tests: XCTestCase {

   // Test extension of String
   func test_osType()
   {
      let codes: [String: OSType?] = [
         "test": 1952805748, "appl": 1634758764, "sys ": 1937339168, "aunt": 1635085940, "out ": 1869968416, "abcde": nil
      ]
      for (string, number) in codes {
         XCTAssert(string.osType() == number)
      }
   }
   
   // Test extension of OSType (aka UInt32 aka FourCharCode)
   func test_osTypeToString()
   {
      let codes: [OSType: String] = [
         1952805748: "test", 1634758764: "appl", 1869968416: "out "
      ]
      for (number, string) in codes {
         XCTAssert(number.fourCharCode() == string)
      }
   }
}
