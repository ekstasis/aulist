//
//  main.swift
//  aulist
//
//  Created by James Baxter on 5/2/19.
//  Copyright © 2019 Spacebug Industries. No rights reserved.
//

import Foundation
import AVFoundation


let test = false

if test {
   print("TESTING")
   let comps = AVAUComponents(manu: "0", componentType: "0", subtype: "0")
   comps.display()
   exit(0)

} else
{
   let numArgs = CommandLine.argc
   let arguments = CommandLine.arguments
   
   if numArgs != 4 {
      print(AVAUComponents.usageMessage)
      exit(666)
   }
   
   let comps = AVAUComponents(manu: arguments[1],
                              componentType: arguments[2],
                              subtype: arguments[3])
   comps.display()
   
   exit(0)
}
