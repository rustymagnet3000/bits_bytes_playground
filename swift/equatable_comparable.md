## Equatable
```
// Inspired by: https://useyourloaf.com/blog/swift-equatable-and-comparable/

struct Country {
    let name: String
    let capital: String
    var visited: Bool
}

let canada = Country(name: "Canada", capital: "Ottawa", visited: true)
let australia = Country(name: "Australia", capital: "Canberra", visited: false)
let uk = Country(name: "United Kingdom", capital: "London", visited: true)
let france = Country(name: "France", capital: "Paris", visited: true)

let object = france
var bucketList = [australia,canada,uk]

let result = bucketList.contains { (c) -> Bool in
    return c.name == object.name &&
        c.capital == object.capital &&
        c.visited == object.visited
}
print(result)

extension Country: Equatable {
    static func == (lhs: Country, rhs: Country) -> Bool {
        return lhs.name == rhs.name &&
            lhs.capital == rhs.capital &&
            lhs.visited == rhs.visited
    }
}

bucketList.append(france)
print(bucketList.contains(france))
```
## Comparable
```
// Inspired by: https://useyourloaf.com/blog/swift-equatable-and-comparable/

struct Country {
    let name: String
    let capital: String
    var visited: Bool
}

let canada = Country(name: "Canada", capital: "Ottawa", visited: true)
let australia = Country(name: "Australia", capital: "Canberra", visited: false)
let uk = Country(name: "United Kingdom", capital: "London", visited: true)
let france = Country(name: "France", capital: "Paris", visited: true)
var bucketList = [uk,australia,canada,france]

extension Country: Comparable {

    static func == (lhs: Country, rhs: Country) -> Bool {
        return lhs.name == rhs.name &&
            lhs.capital == rhs.capital &&
            lhs.visited == rhs.visited
    }

    static func < (lhs: Country, rhs: Country) -> Bool {
        return lhs.name < rhs.name ||
            (lhs.name == rhs.name && lhs.capital < rhs.capital) ||
            (lhs.name == rhs.name && lhs.capital == rhs.capital && rhs.visited)
    }
}

extension Country {
    static func prettyPrint(a: [Country]) {
        for i in a {
            print(i.name)
        }
        let banner = String(repeating: "*", count: 20)
        print(banner)
    }
}

// Not sorted
Country.prettyPrint(a: bucketList)

// use the Comparable extension
Country.prettyPrint(a: bucketList.sorted())

// The longer way, but this mutates the actual array
bucketList.sort { (lhs: Country, rhs: Country) -> Bool in
    return lhs.name < rhs.name || (lhs.name == rhs.name && lhs.capital < rhs.capital)
}

Country.prettyPrint(a: bucketList)
```
