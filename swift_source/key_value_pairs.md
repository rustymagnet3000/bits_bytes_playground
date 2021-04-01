## KeyValuePairs
```
// https://developer.apple.com/documentation/swift/keyvaluepairs
// https://www.hackingwithswift.com/example-code/language/what-are-keyvaluepairs

let recordTimes: KeyValuePairs = ["Florence Griffith-Joyner": 10.49,
                                  "Evelyn Ashford": 10.76,
                                  "Evelyn Ashford": 10.79,
                                  "Marlies Gohr": 10.81]

var runner = "Marlies Gohr"
print(recordTimes.firstIndex(where: { $0.0 == runner })!)

runner = "Marlies Gohrs"
print(recordTimes.firstIndex(where: { $0.0 == runner }) ?? -999)

for i in recordTimes {
    print(i.key + " set a World Record at: \(i.value)")
}

print("\(recordTimes[0].key) is my favourite winner, at: \(recordTimes[0].value)")
```
## KeyValuePairs with Array
```
struct SpidersFearFactor {
    var elements: [(Int, String)]

    init(_ elements: KeyValuePairs<Int, String>) {
        self.elements = Array(elements)
    }
}

var pairs = SpidersFearFactor([5: "Wolf", 1: "Huntsmen", 3: "Wandering", 2: "Trapdoor"])

pairs.elements.append((1, "Redback"))
pairs.elements.reverse()
print(pairs.elements)
```
