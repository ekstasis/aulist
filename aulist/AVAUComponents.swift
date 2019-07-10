//
//  AVAUComponents.swift
//  aulist
//
//  Created by James Baxter on 5/2/19.
//  Copyright © 2019 Spacebug Industries. All rights reserved.
//

import AVFoundation
import AudioToolbox

/// A means to gather, store, and display AU Components
struct AVAUComponents
{
   // MARK: Properties
   let manu: OSType
   let componentType: OSType
   let subtype: OSType
   let manager = AVAudioUnitComponentManager.shared()
   var components: [AVAudioUnitComponent]
   var count = 0
   
   // MARK: Functions
   
   /// Gathers and stores the list of AU Components that match a given component description
   /// - Parameters:
   ///   - manu:  The unique vendor identifier, e.g., "appl".
   ///   - componentType: Identifies the interface for the component, e.g,. "aufx".
   ///   - subtype: Indicates the purpose of a component, e.g., "gate".
   ///
   init(manu: String = "0", componentType: String = "0", subtype: String = "0")
   {
      self.manu = manu == "0" ? 0 : manu.osType()!
      self.componentType = componentType == "0" ? 0 : componentType.osType()!
      self.subtype = subtype == "0" ? 0 : subtype.osType()!
      
      var componentDescription = AudioComponentDescription()
      componentDescription.componentManufacturer = self.manu
      componentDescription.componentType = self.componentType
      componentDescription.componentSubType = self.subtype
      componentDescription.componentFlags = 0
      componentDescription.componentFlagsMask = 0

      components = manager.components(matching: componentDescription)
      count = components.count
      components.sort()
   }
   
   func display()
   {
      guard count >= 1 else {
         print("\nNo components found.\n")
         return
      }
      
      // "Apple: DynamicsCompressor"
      let names: [(String, String)] = components.map { componentNames(comp: $0) }
      let nameStrings: [String] = names.map { "\($0): \($1)" }
      
      // "( appl aufx dncp )"
      let codes: [(String, String, String)]  = components.map { componentCodes(comp: $0) }
      let codeStrings = codes.map { "( \($0) \($1) \($2) )" }
      
      // "( 28838838 38883838 9939222 )"
      let numbers: [(OSType, OSType, OSType)]  = components.map { codeNumbers(comp: $0) }
      let numberStrings = numbers.map { "( \($0) \($1) \($2) )" }
      
      // "( -EW- aumu EwPl )  ( 759519021 1635085685 1165447276 )"
      let fullStrings = zip(codeStrings, numberStrings).map { (str, num) in
         return "\(str)  \(num)"
      }
      
      var lengthOfLongestName = 0
      for name in nameStrings {
         if name.count > lengthOfLongestName { lengthOfLongestName = name.count }
      }
      for (name, code) in zip(nameStrings, fullStrings) {
         let numSpaces = lengthOfLongestName - name.count + 2
         let space = String(repeating: " ", count: numSpaces)
         // "Tokyo Dawn Labs: TDR VOS SlickEQ               ( Tdrl aufx Td10 )  ( 1415869036 1635083896 1415852336 )"
         print(name, space, code)
      }
      print()
      print("-------------------------------------------------------------------------------")
      
      // Summary
      let numFound = components.count
      print("\(numFound) component", terminator: "")
      print(numFound == 1 ? "" : "s")
      print()
   }
   
   func componentNames(comp: AVAudioUnitComponent) -> (String, String)
   {
      return (comp.manufacturerName, comp.name)
   }
   
   func componentCodes(comp: AVAudioUnitComponent) -> (String, String, String)
   {
      let desc = comp.audioComponentDescription
      return (desc.componentManufacturer.fourCharCode(),
         desc.componentType.fourCharCode(),
         desc.componentSubType.fourCharCode())
   }
   
   func codeNumbers(comp: AVAudioUnitComponent) -> (OSType, OSType, OSType)
   {
      let desc = comp.audioComponentDescription
      return (desc.componentManufacturer,
              desc.componentType,
              desc.componentSubType)
   }
   
   // Mark: Usage Message
   static let usageMessage = """

   Usage:  aulist manufacturer type subtype

   Arguments can be "0" which doesn't filter by that criterion (showing components by any manufacturer, for instance)

   Examples:
   $ aulist appl aufx dcmp    <- a single plugin
   $ aulist 0    aufx 0       <- all effect plugins
   $ aulist appl 0    0       <- all apple plugins  \n

"""
}

/*
Alternative component lookup methods

var comp = AudioComponentFindNext(nil, &componentDescription)
var count = 0

while comp != nil {
   var nextDescription = AudioComponentDescription()
   AudioComponentGetDescription(comp!, &nextDescription)
   print(nextDescription.componentManufacturer.string(), nextDescription.componentType.string(),
         nextDescription.componentSubType.string(), nextDescription.componentFlags)
   comp = AudioComponentFindNext(comp, &componentDescription)
   count += 1
}

print("\n COUNT: \(count) \n")

let theManu = self.manu
components = manager.components(passingTest: { comp, stop in
   print("Testing: \(comp.audioComponentDescription)")
   print("AVAudioUnit.manufacturerName: \(comp.manufacturerName)")
   if comp.audioComponentDescription.componentFlags == 2 {
      return true
   } else {
      return comp.audioComponentDescription.componentManufacturer == theManu
   }
})
*/
