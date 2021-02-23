## Codable
### Decode
```
import Cocoa
import PlaygroundSupport

enum YDCut : Int, Codable {
    case    Last_Three = 3
    case    Last_Six = 6
    case    Default = 1
}

struct ExampleData: Codable {
    var array : [Int]
    var dict : [String : String]
    var number: Int
    let cut: YDCut?
}

if let a =
    """
{"array":[0,1,2,3],"dict":{"lang":"Swift","name":"Vapor"},"number":123,"string":"test", "cut":3}
""".data(using: .utf8) {
    let example = try JSONDecoder().decode(ExampleData.self, from: a)
    print(example.array)
    print(example.dict)
    print(example.number)
    print(example.cut.debugDescription)
}

```
### Encode
```
import Foundation
import PlaygroundSupport

struct nameStruct: Encodable {
    let Name: String
}

let rawName = "Rusty Robot"
var a = nameStruct(Name: rawName)
let jsonData = try! JSONEncoder().encode(a)
let jsonString = String(data: jsonData, encoding: .utf8)!
print(jsonString)
```
### Escaped forward slashes
```
struct YDEnrol: Codable {
    let MyMessage: String
}

let prebase64string = "BuhXa4CwQRI/"
var a = YDEnrol(MyMessage: prebase64string)

let encoder = JSONEncoder()
let jsonData: Data = try! encoder.encode(a)

let jsonString = String(data: jsonData, encoding: .utf8)!
print("🦂 " + jsonString)
//  🦂 {"MyMessage":"BuhXa4CwQRI\/"}

let str = String(data: jsonData, encoding: .utf8)?.replacingOccurrences(of: "\\/", with: "/")
print("🐝 " + str!)
// 🐝 {"MyMessage":"BuhXa4CwQRI/"}
```
