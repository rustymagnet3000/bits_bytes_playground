## Errors
Error handling with Swift is notably different to ObjC. Swift uses a Protocol (`Error`) whereas ObjC uses a Class (`NSError`).  I prefer the ObjC way, as it leads to simpler code. The below Swift sample is a summary of the code on: https://nshipster.com/swift-foundation-error-protocols/
```

import Foundation
import PlaygroundSupport

struct Broth {
  enum Error {
    case tooManyCooks(Int)
  }

  init(numberOfCooks: Int) throws {
    precondition(numberOfCooks > 0)
    guard numberOfCooks < 100 else {
      throw Error.tooManyCooks(numberOfCooks)
    }
  }
}

extension Broth.Error: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .tooManyCooks(let numberOfCooks):
            return "Too Many Cooks (\(numberOfCooks))"
        }
    }

    var failureReason: String? {
        switch self {
        case .tooManyCooks:
            return "It's difficult to reconcile many opinions."
        }
    }

    var recoverySuggestion: String? {
        switch self {
        case .tooManyCooks:
            return "Reduce the number of decision makers."
        }
    }
}


do {
    let b = try Broth(numberOfCooks: 90)
    print("success \(b.self)")
    let c = try Broth(numberOfCooks: 100)
    }
catch let error as LocalizedError {
    let title = error.errorDescription
    let message = [
       error.failureReason,
       error.recoverySuggestion
    ].compactMap { $0 }
    .joined(separator: "\n\n")

    print(message)
} catch {
    // handle other errors...
}
```
