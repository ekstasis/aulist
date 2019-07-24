//
//  main.swift
//  aulist
//
//  Created by James Baxter on 5/2/19.
//  Copyright © 2019 Spacebug Industries. No rights reserved.
//

import Foundation
import AVFoundation


let arguments = Array(CommandLine.arguments.dropFirst())

var options: Options? = nil

#if DEBUG
print("\nCommand Line Arguments:  \(arguments)")
#endif

print()

options = Options(cliArgs: arguments)

if options == nil {
    AVAUComponents.printUsageMessage()
    exit(1)
}

#if DEBUG
print(options!, "\n")
#endif

let components = AVAUComponents(options: options!)
components.display()

exit(0)

