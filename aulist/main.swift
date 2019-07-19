//
//  main.swift
//  aulist
//
//  Created by James Baxter on 5/2/19.
//  Copyright © 2019 Spacebug Industries. No rights reserved.
//

import Foundation
import AVFoundation


let arguments = Array<String>(CommandLine.arguments.dropFirst())

guard let options = Options(cliArgs: arguments) else {
    AVAUComponents.printUsageMessage()
    exit(1)
}

let components = AVAUComponents(options: options)
components.display()

exit(0)

