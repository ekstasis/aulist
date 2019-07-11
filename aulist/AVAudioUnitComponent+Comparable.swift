//
//  AVAudioUnitComponent+Comparable.swift
//  aulist
//
//  Created by James Baxter on 6/2/19.
//  Copyright © 2019 Spacebug Industries. All rights reserved.
//

import Foundation
import AVFoundation


extension AVAudioUnitComponent: Comparable
{
   public static func < (lhs: AVAudioUnitComponent, rhs: AVAudioUnitComponent) -> Bool {
      let lhsDesc = lhs.audioComponentDescription
      let lhsManu = lhsDesc.componentManufacturer.fourLetters().lowercased()
      let lhsType = lhsDesc.componentType.fourLetters().lowercased()
      let lhsSubType = lhsDesc.componentSubType.fourLetters().lowercased()
      
      let rhsDesc = rhs.audioComponentDescription
      let rhsManu = rhsDesc.componentManufacturer.fourLetters().lowercased()
      let rhsType = rhsDesc.componentType.fourLetters().lowercased()
      let rhsSubType = rhsDesc.componentSubType.fourLetters().lowercased()
      
      if lhsManu != rhsManu {
         return lhsManu < rhsManu
      } else if lhsType != rhsType {
         return lhsType < rhsType
      } else {
         return lhsSubType < rhsSubType
      }
   }
   
   public static func == (lhs: AVAudioUnitComponent, rhs: AVAudioUnitComponent) -> Bool {
      let lhsDesc = lhs.audioComponentDescription
      let lhsManu = lhsDesc.componentManufacturer.fourLetters().lowercased()
      let lhsType = lhsDesc.componentType.fourLetters().lowercased()
      let lhsSubType = lhsDesc.componentSubType.fourLetters().lowercased()
      
      let rhsDesc = rhs.audioComponentDescription
      let rhsManu = rhsDesc.componentManufacturer.fourLetters().lowercased()
      let rhsType = rhsDesc.componentType.fourLetters().lowercased()
      let rhsSubType = rhsDesc.componentSubType.fourLetters().lowercased()
      
      return lhsManu == rhsManu && lhsType == rhsType && lhsSubType == rhsSubType
   }
}

