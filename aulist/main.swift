//
//  main.swift
//  aulist
//
//  Created by James Baxter on 5/2/19.
//  Copyright © 2019 Spacebug Industries. No rights reserved.
//

import Foundation


let numArgs = CommandLine.argc
let arguments = CommandLine.arguments

if numArgs != 4 {
   print(AVAUComponents.usageMessage)
   exit(666)
}

if let comps = AVAUComponents(manu: arguments[1],
                              componentType: arguments[2],
                              subtype: arguments[3])
{
   comps.display()
} else {
   print(AVAUComponents.usageMessage)
}

exit(0)
