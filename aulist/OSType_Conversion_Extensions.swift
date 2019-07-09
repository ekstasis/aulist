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
   /**
    Converts [self], a four-letter string, to an OSType, aka FourCharCode,
    aka unsigned int.  E.g., "appl".osType() => 1634758764
    
    - Returns: An OSType (unsigned int)
    */
   func osType() -> OSType?
   {
      guard count <= 4 else { return nil }
      // pad to 4 letters (e.g. "sys")
      let spaces = String(repeating: " ", count: 4 - self.count)
      let string = self + spaces
      var number: OSType = 0
      string.utf8.forEach {
         number = number << 8 | OSType($0) }
      return number
   }
}

extension OSType
{
   /**
    Converts [self], an OSType (aka FourCharCode, aka unsigned int) to
    a four-letter string.  E.g., 1634758764.string() => "appl"
    
    - Returns: A String
    */
   func fourCharCode() -> String {
      var string = ""
      string.append(Character(UnicodeScalar(self >> 24 & 0xFF)!))
      string.append(Character(UnicodeScalar(self >> 16 & 0xFF)!))
      string.append(Character(UnicodeScalar(self >> 8 & 0xFF)!))
      string.append(Character(UnicodeScalar(self & 0xFF)!))
      return string
   }
}

