## URLSession
### Using a Completion Block
```
class YDURLSession {

    enum FetchResult {
        case Success
        case Data
        case Error(Int)
    }
    let url = URL(string: "https://httpbin.org/get")
    let session = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?

    func fetchWithCompletionHandler(completionHandler: @escaping (FetchResult)-> (Void)) {

        dataTask = session.dataTask(with: url!) { [weak self] data, response, error in
            defer {
              self?.dataTask = nil
            }

            var result: FetchResult = .Success

            if let e = error {
                result = .Error(e._code)
            }

          DispatchQueue.main.async {
            completionHandler(result)
          }
        }

        dataTask?.resume()
    }
}

let a = YDURLSession()
a.fetchWithCompletionHandler { (result) in
    switch result {
    case .Success:
        print("success")
    case .Error(let errorcode):
        print("error \(errorcode)")
    default:
        print("default failure")
    }
}
```
