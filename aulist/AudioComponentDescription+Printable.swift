//
//  AudioComponentDescription+Printable.swift
//  aulist
//
//  Created by James Baxter on 6/2/19.
//  Copyright © 2019 Spacebug Industries. All rights reserved.
//

import Foundation
import AVFoundation

extension AudioComponentDescription : CustomStringConvertible {
   public var description: String {
      return "\(self.componentManufacturer.fourLetters()) / \(self.componentType) / \(self.componentSubType) :: \(self.componentFlags), \(self.componentFlagsMask)"
   }
}
