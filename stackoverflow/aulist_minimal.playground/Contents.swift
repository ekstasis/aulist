import AudioToolbox
import AVFoundation

let manager = AVAudioUnitComponentManager.shared()

var componentDescription = AudioComponentDescription()
componentDescription.componentManufacturer = 0
componentDescription.componentType = 0
componentDescription.componentSubType = 0
componentDescription.componentFlags = 0
componentDescription.componentFlagsMask = 0

let components = manager.components(matching: componentDescription)

components.forEach {
   print($0.manufacturerName, $0.name)
}

let numFound = components.count
print("\nFound \(numFound) component", terminator: "")
print(numFound == 1 ? "" : "s")
print()
