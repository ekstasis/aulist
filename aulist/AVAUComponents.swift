//
//  AVAUComponents.swift
//  aulist
//
//  Created by James Baxter on 5/2/19.
//  Copyright © 2019 Spacebug Industries. All rights reserved.
//

import AVFoundation

/*
 See extensions of OSType and String at bottom of file
 */

struct AVAUComponents
{
   let manu: OSType
   let componentType: OSType
   let subtype: OSType

   let manager = AVAudioUnitComponentManager.shared()
   let componentDescription: AudioComponentDescription
   let components: [AVAudioUnitComponent]
   
   static let usageMessage = """
\nUsage:  aulist manufacturer type subtype

   Arguments can be "0" which doesn't filter by that criterion (showing components by any manufacturer, for instance)

   Examples:
   $ aulist appl aufx dcmp    <- a single plugin
   $ aulist 0    aufx 0       <- all effect plugins
   $ aulist appl 0    0       <- all apple plugins  \n
"""
   
   init?(manu: String = "0", componentType: String = "0", subtype: String = "0")
   {
      // init fails if an argument is given but is not 4 characters long
      
      if manu == "0" { self.manu = 0 }
      else if let manuCode = manu.osType() { self.manu = manuCode }
      else {
         return nil
      }
      if componentType == "0" { self.componentType = 0 }
      else if let componentTypeCode = componentType.osType() { self.componentType = componentTypeCode }
      else {
         return nil
      }
      if subtype == "0" { self.subtype = 0 }
      else if let subtypeCode = subtype.osType() { self.subtype = subtypeCode }
      else {
         return nil
      }

      componentDescription = AudioComponentDescription(componentType: self.componentType, componentSubType: self.subtype,
                                                       componentManufacturer: self.manu, componentFlags: 0, componentFlagsMask: 0)
      components = manager.components(matching: componentDescription)
   }

   func display()
   {
      print()
      let _ = components.map { printComponent(comp: $0) }
      print("-------------------------------------------------------------------------------")
      let numFound = components.count
      print("\(numFound) component", terminator: "")
      print(numFound == 1 ? "" : "s")
      print()
   }
   
   func printComponent(comp: AVAudioUnitComponent)
   {
      print(comp.manufacturerName, ": ", comp.name, separator: "", terminator: "")
      
      print("\t(", terminator: "")
      printCodes(comp: comp)
      print(")")
   }
   
   func printCodes(comp: AVAudioUnitComponent)
   {
      let desc = comp.audioComponentDescription
      print(desc.componentManufacturer.string(), // string() is extension on OSType
            desc.componentType.string(),
            desc.componentSubType.string(), terminator: "")
   }
}

