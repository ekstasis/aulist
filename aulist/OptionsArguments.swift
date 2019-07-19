//
//  OptionsArguments.swift
//  aulist
//
//  Created by James Baxter on 7/19/19.
//  Copyright © 2019 Spacebug Industries. All rights reserved.
//

import Foundation


struct Option {
    let name: String
    let desc: String
}


struct Options : CustomStringConvertible {
    
    static let availableOptions: [Option] = [
        Option(name: "no_apple", desc: "Show only 3rd-party plugins"),
        Option(name: "apple_only", desc: "Show only plugins with manufacturer \"appl\""),
        Option(name: "no_ints", desc: "Only show codes as strings; no integers"),
        Option(name: "no_views", desc: "Don't show AUs of type 'auvw'")
    ]
    
    /// An array of Options, representing command line arguments beginning with "--", e.g., "--no_apple" (hyphens are stripped out)
    var options = [Option]()
    
    /// An array of arguments, representing command line arguments not beginnning with "--".
    /// Should be the last 3 arguments and represent manufacturer code, au type code, and au subtype code, e.g.,
    ///     appl aufx dyna
    var arguments = [String]()
    
    init?(cliArgs: [String]) {
        if !parse(commandline: cliArgs) {
            return nil
        }
        var numMissingArgs = 3 - self.arguments.count
        while (numMissingArgs > 0) {
            arguments.append("0")
            numMissingArgs -= 1
        }
    }
    
    func isSet(option: String) -> Bool {
        for opt in options {
            if opt.name == option {
                return true
            }
        }
        return false
    }
    
    mutating func parse(commandline: [String]) -> Bool {
        var foundBadOption = false
        for arg in commandline {
            if arg.hasPrefix("--") {
                let opt_str = arg.dropFirst().dropFirst()
                var opt = Option(name: "", desc: "")
                if Options.availableOptions.contains(where: {
                    if $0.name == opt_str {
                        opt = $0
                        return true
                    } else {
                        return false
                    }}) {
                    options.append(opt)
                } else {
                    foundBadOption = true
                }
            } else {
                arguments.append(arg)
            }
        }
        return !foundBadOption
    }
    
    static func availableOptionsString() -> String {
        return optionsString(opts: Options.availableOptions)
    }
    
    static let maxOptionLength: Int = {
        var maxOptionNameLength = 0
        Options.availableOptions.forEach {
            let optionNameLength = $0.name.count
            if optionNameLength > maxOptionNameLength {
                maxOptionNameLength = optionNameLength
            }
        }
        return maxOptionNameLength
    }()
    
    static func optionsString(opts: [Option]) -> String {
        var string = ""
        string += "Options:\n"
        opts.forEach {
            let padding = String(repeating: " ", count: maxOptionLength - $0.name.count)
            string += "\t--\($0.name)\(padding)\t\($0.desc)\n"
        }
        return string
    }
    
    var description: String {
        var desc = ""
        desc += Options.optionsString(opts: options)
        desc += "Arguments:"
        arguments.forEach {
            desc += " '\($0)'"
        }
        return desc
    }
    
    static let defaultOptions: Options = {
        return Options(cliArgs: ["0", "0", "0"])!
    }()
}

