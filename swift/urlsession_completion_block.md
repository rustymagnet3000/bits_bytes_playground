## URLSession
### Using a Completion Block. Prints Cookies and HTTP status code.
```
import CryptoKit
import Foundation

class YDURLSession {

    enum FetchResult {
        case Success
        case Unknown
        case Error(Int)
    }
    let url = URL(string: "https://httpbin.org/cookies/set/FOOCOOKIE/BARBARBAR")!
    
    func fetchWithCompletionHandler(completionHandler: @escaping (FetchResult)-> (Void)) {
        print("🐝Started. Called: \(url.absoluteString)")
        let dataTask = URLSession.shared.dataTask(with: url) { data, resp, error in

            var result: FetchResult = .Unknown

            if let e = error {
                result = .Error(e._code)
            }

            if let response = resp as? HTTPURLResponse {
                
                if(200..<300).contains(response.statusCode){
                    print("🐝HTTPStatusCode: \(response.statusCode)")
                    result = .Success
                }
                
                if let cookies:[HTTPCookie] = HTTPCookieStorage.shared.cookies{
                    for cookie:HTTPCookie in cookies as [HTTPCookie] {
                        print("🐝\(cookie.name)")
                    }
                }
            }
          DispatchQueue.main.async {
            completionHandler(result)
          }
        }

        dataTask.resume()
    }
}

let a = YDURLSession()
a.fetchWithCompletionHandler { (result) in
    switch result {
    case .Success:
        print("🐝success")
    case .Error(let errorcode):
        print("🐝error \(errorcode)")
    case .Unknown:
            print("🐝unknown response")
    }
}


```
