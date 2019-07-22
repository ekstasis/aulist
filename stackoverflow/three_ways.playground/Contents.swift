import AudioToolbox
import AVFoundation


var componentDescription = AudioComponentDescription()
componentDescription.componentManufacturer = 0
componentDescription.componentType = 0
componentDescription.componentSubType = 0
componentDescription.componentFlags = 0
componentDescription.componentFlagsMask = 0

let manager = AVAudioUnitComponentManager.shared


func fourLetters(ostype: OSType) -> String {
    var string = ""
    string.append(Character(UnicodeScalar(ostype >> 24 & 0xFF)!))
    string.append(Character(UnicodeScalar(ostype >> 16 & 0xFF)!))
    string.append(Character(UnicodeScalar(ostype >> 8 & 0xFF)!))
    string.append(Character(UnicodeScalar(ostype & 0xFF)!))
    return string
}

func osType(str: String) -> OSType?
{
    guard str.count <= 4 else { return nil }
    // pad to 4 letters (e.g. "sys")
    let spaces = String(repeating: " ", count: 4 - str.count)
    let string = str + spaces
    var number: OSType = 0
    string.utf8.forEach {
        number = number << 8 | OSType($0) }
    return number
}

func managerComponents()
{
    print("managerComponents():")
    
    let components = manager().components(matching: componentDescription)
    
    components.forEach {
        let manu = $0.manufacturerName
        if manu != "Apple" {
            print($0.manufacturerName, $0.name)
        }
    }
    let numFound = components.count
    print("Found \(numFound) component", terminator: "")
    print(numFound == 1 ? "" : "s")
    print()
}

managerComponents()


func findNext()
{
    print("findNext():")
    var comp = AudioComponentFindNext(nil, &componentDescription)
    var count = 0
    
    while comp != nil {
        var nextDescription = AudioComponentDescription()
        AudioComponentGetDescription(comp!, &nextDescription)
        if fourLetters(ostype: nextDescription.componentManufacturer) != "appl" {
            print(fourLetters(ostype: nextDescription.componentManufacturer), fourLetters(ostype: nextDescription.componentType),
                  fourLetters(ostype: nextDescription.componentSubType), nextDescription.componentFlags)
        }
        comp = AudioComponentFindNext(comp, &componentDescription)
        count += 1
    }
    print("found: \(count) \n")
}

findNext()

func passingTest()
{
    print("passingTest()")
    //    let theManu = osType(str: "appl")
    let components = manager().components(passingTest: { comp, stop in
        if comp.manufacturerName != "Apple" {
            print("AVAudioUnit.manufacturerName: \(comp.manufacturerName)")
        }
        return true
    })
    print("Found \(components.count) components")
}

passingTest()





