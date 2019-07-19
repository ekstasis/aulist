//
//  AVAUComponents.swift
//  aulist
//
//  Created by James Baxter on 5/2/19.
//  Copyright © 2019 Spacebug Industries. All rights reserved.
//

import AVFoundation
import AudioToolbox

/// A means to gather, store, and list AU Components and their codes
struct AVAUComponents
{
    // MARK: Properties
    let manu: OSType
    let componentType: OSType
    let subtype: OSType
    let manager = AVAudioUnitComponentManager.shared()
    var components: [AVAudioUnitComponent]
    var count = 0
    let options: Options
    
    // MARK: - Functions
    
    /// Gathers and stores the list of AU Components that match a given component description
    /// - Parameters:
    ///   - options:  an Options struct containing options and arguments, e.g., "--no_apple" and "aufx"
    init(options: Options)
    {
        self.options = options
        let manu = options.arguments[0]
        let componentType = options.arguments[1]
        let subtype = options.arguments[2]
        
        // convert string arguments to OSType
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
    
    // MARK: display() and helpers

    /// For each AU in self.components, print manufacturer, name, string codes, and optionally numerical codes, e.g.:
    /// "Apple: DynamicsCompressor   ( appl aufx dncp )   ( 28838838 38883838 9939222 )"
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
        var numberStrings = [String]()
        if !options.isSet(option: "no_ints") {
            let numbers: [(OSType, OSType, OSType)]  = components.map { codeNumbers(comp: $0) }
            numberStrings = numbers.map { "( \($0) \($1) \($2) )" }
        }
        
        // "( -EW- aumu EwPl )  ( 759519021 1635085685 1165447276 )"
        var fullStrings = [String]()
        if options.isSet(option: "no_ints") { // option to leave off integer version of codes
            fullStrings = codeStrings
        } else {
            fullStrings = zip(codeStrings, numberStrings).map { (str, num) in
                return "\(str)  \(num)"
            }
        }
        
        let longestName = nameStrings.max {
            $0.count < $1.count
        }
        let lengthOfLongestName = longestName?.count ?? 0
        
        let displayLines = zip(nameStrings, fullStrings).map { (name: String, code: String) -> String in
            let numSpaces = lengthOfLongestName - name.count + 2
            let space = String(repeating: " ", count: numSpaces)
            return "\(name) \(space) \(code)"
        }

        displayLines.forEach { print($0) }
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
        return (desc.componentManufacturer.fourLetters(),
                desc.componentType.fourLetters(),
                desc.componentSubType.fourLetters())
    }
    
    func codeNumbers(comp: AVAudioUnitComponent) -> (OSType, OSType, OSType)
    {
        let desc = comp.audioComponentDescription
        return (desc.componentManufacturer,
                desc.componentType,
                desc.componentSubType)
    }
    
    // MARK: Usage Message
    static func printUsageMessage() {
        let message = """
        
        Usage:  aulist [options] manufacturer type subtype
        
        \(Options.availableOptionsString())
        Arguments can be "0" which doesn't filter by that criterion (showing components by any manufacturer, for instance)
        
        Examples:
        $ aulist appl aufx dcmp    <- a single plugin
        $ aulist 0    aufx 0       <- all effect plugins
        $ aulist appl 0    0       <- all apple plugins  \n
        
        """
        print(message)
    }
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
