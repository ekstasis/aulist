//
//  OSType_Conversion.swift
//  aulist
//
//  Created by James Baxter on 5/3/19.
//  Copyright © 2019 Spacebug Industries. All rights reserved.
//

import Foundation


extension String
{
   func osType() -> UInt32? {
      guard self.count == 4 else { return nil }
      var iter = self.utf8.makeIterator()
      var number: UInt32 = 0
      while let digit = iter.next() {
         number = number << 8
         number = number | UInt32(digit)
      }
      return number
   }
}

extension OSType {
   func string() -> String {
      var string = ""
      string.append(Character(UnicodeScalar(self >> 24 & 0xFF)!))
      string.append(Character(UnicodeScalar(self >> 16 & 0xFF)!))
      string.append(Character(UnicodeScalar(self >> 8 & 0xFF)!))
      string.append(Character(UnicodeScalar(self & 0xFF)!))
      return string
   }
}

