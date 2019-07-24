//
//  OptionsArguments.swift
//  aulist
//
//  Created by James Baxter on 7/19/19.
//  Copyright © 2019 Spacebug Industries. All rights reserved.
//

import Foundation


public enum Option: String, CaseIterable {

    case help, no_apple, no_ints, no_views
    
    static let descriptions: [Option: String] = [
        .help:          "Print usage message",
        .no_apple:      "Show only 3rd-party plugins",
        .no_ints:       "Only show codes as strings; no integers",
        .no_views:      "Don't show AUs of type 'auvw'"
    ]
    
    var name: String {
        return rawValue
    }
    
    var description: String {
        return Option.descriptions[self]!
    }

    static let maxOptionLength: Int =
        Option.allCases.map { $0.name.count }.max() ?? 0
    
    static var validOptions: String {
        var string = ""
        string += "Options:\n"
        Option.allCases.forEach {
            let padding = String(repeating: " ", count: Option.maxOptionLength - $0.name.count)
            string += "\t--\($0.name)\(padding)\t\($0.description)\n"
        }
        return String(string.dropLast())
    }
    
}


public struct Options : CustomStringConvertible {
    var options = [Option]()  // e.g., "--no_apple"
    var arguments = [String]() // e.g., "appl", "aufx"
    
    init?(cliArgs: [String]) {
        // options:  i.e., args that start with hyphens
        var opts = cliArgs.filter({
            $0.starts(with: "-")
        })
        opts = opts.map({  // strip hyphens
            String($0.drop(while: {$0 == "-"}))
        })
        opts = Array(opts)
        
        options = opts.compactMap { Option(rawValue: $0) }
        
        if options.contains(.help) {           
            return nil
        }
        
        if options.count < opts.count { return nil }  // unknown argument = fail, print usage

        // arguments:  everything else
        arguments = Array(cliArgs.filter { !$0.starts(with: "-")})

        // Missing arguments are filled with "0"
        var numMissingArgs = 3 - self.arguments.count
        while (numMissingArgs > 0) {
            arguments.append("0")
            numMissingArgs -= 1
        }
    }
    
    func isSet(option: Option) -> Bool {
        return options.contains(option)
    }
   
    /// The list of set options and their descriptions
    func optionsString() -> String {
        var string = ""
        string += "Set Options:\n"
        options.forEach {
            let padding = String(repeating: " ", count: Option.maxOptionLength - $0.name.count)
            string += "\t\($0.name)\(padding)\t\($0.description)\n"
        }
        return string
    }
    
    public var description: String {
        var desc = ""
        desc += optionsString()
        desc += "Arguments:\n\t"
        arguments.forEach {
            desc += "'\($0)'"
        }
        return desc
    }
    
    static let defaultOptions = Options(cliArgs: ["0", "0", "0"])!
}

