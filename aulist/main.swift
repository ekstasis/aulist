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

print("\nCommand Line Arguments:  \(arguments)\n")

options = Options(cliArgs: arguments)

if options == nil {
    AVAUComponents.printUsageMessage()
    exit(1)
} else {
    print(options!, "\n")
}

let components = AVAUComponents(options: options!)
components.display()

exit(0)

