//
//  AVAUConponents_Tests.swift
//  AVAUConponents_Tests
//
//  Created by James Baxter on 5/2/19.
//  Copyright © 2019 Spacebug Industries. All rights reserved.
//

import XCTest

class AVAUComponents_Tests: XCTestCase {
    
    // Test basic functionality, which happens in init(manu, type, subtype)
    func testInit()
    {
        // All AUs
        var comps = AVAUComponents(options: Options.defaultOptions)
        XCTAssert(comps.manu == 0 && comps.componentType == 0 && comps.subtype == 0)
        XCTAssert(comps.components.count > 10)
        
        // All Apple AUs
        comps = AVAUComponents(options: Options(cliArgs: ["appl", "0", "0"])!)
        let appl = 1634758764
        XCTAssert(comps.manu == appl && comps.componentType == 0 && comps.subtype == 0)
        XCTAssert(comps.components.count > 10)
        let nonAppleComponents = comps.components.filter {
            $0.audioComponentDescription.componentManufacturer != appl
        }
        XCTAssert(nonAppleComponents.count == 0)
        
        // Apple: AUDynamicsProcessor (appl aufx dcmp)
        comps = AVAUComponents(options: Options(cliArgs: ["appl", "aufx", "dcmp"])!)
        let comp = comps.components[0]
        XCTAssert(comps.components.count == 1)
        XCTAssert(comp.manufacturerName == "Apple")
        XCTAssert(comp.typeName == "Effect")
        XCTAssert(comp.name == "AUDynamicsProcessor")
        XCTAssert(comps.manu == appl && comps.componentType == "aufx".osType() &&
            comps.subtype == "dcmp".osType())
        
        //
        XCTAssert(AVAUComponents(options: Options(cliArgs: ["SBI", "hell", "0"])!).count == 0)
    }
}
