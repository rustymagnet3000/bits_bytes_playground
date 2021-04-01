## Enums
### Stop an Enum failing
```
import Cocoa
import PlaygroundSupport

enum YDCutColumns : Int, Codable {
    case    Last_Three = 3
    case    Last_Six = 6
    case    Last_Eighteen = 18
    case    Default = 1
}


let a = YDCutColumns(rawValue: 1)
let b = YDCutColumns(rawValue: 6)
let c = YDCutColumns(rawValue: 7) ?? .Default // avoid init fail with a default
print(a!)
print(b!)
print(c) // no requirement to Force Unwrap
print(c.rawValue)
