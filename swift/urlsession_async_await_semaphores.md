## URLSession
### Async and Wait ( using Semaphores )
```
import Foundation

final class YDslimURLSession {

    enum FetchResult {
        case Success
        case Error(Int)
    }

    static func fetchAsyncAwait() -> FetchResult {

        var result: FetchResult = .Error(-1)

        guard let url = URL(string: "https://httpbin.org/get") else {
            result = .Error(999)
            return result
        }

        let semaphore = DispatchSemaphore(value: 0)
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let _ = data {
                result = .Success
            }

            if let error = error {
                result = .Error(error._code)
            }

            semaphore.signal()
        }.resume()
        semaphore.wait(timeout: .distantFuture)
        return result
    }
}

for counter in 1...3 {
    let result = YDslimURLSession.fetchAsyncAwait()
    switch result {
    case .Success:
        print("Response \(counter) ✅")
    case .Error(let error):
        print("Response \(counter) ❌ \(error)")
    }
}

print("end of program")
```
