## URLSession
### Using Delegates
```
import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

class YDCalypso: NSObject, URLSessionTaskDelegate, URLSessionDataDelegate {
    let destUrl: String
    let request: URLRequest
    let httpmethod: String
    var receivedData: Data?

    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        return URLSession(configuration: configuration,
                          delegate: self, delegateQueue: nil)
    }()

    init(url: String, httpMethod: String) {
        self.destUrl = url
        self.httpmethod = httpMethod
        self.request = URLRequest(url: URL(string: url)!)
    }

    func fire() {
        receivedData = Data()
        let task = session.dataTask(with: request)
        task.resume()
    }

    /* URLSessionTaskDelegate */
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        guard let httpResponse = response as? HTTPURLResponse else {
            return
        }
        print("httpResponse.statusCode \(httpResponse.statusCode)")
        completionHandler(.allow)
    }

    /* URLSessionDataDelegate */
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        receivedData = data
        let str = String(decoding: data, as: UTF8.self)
        print(str)
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let e = error {
            print("error \(e._code)")
        }
    }

    /* URLSession */
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print("received challenge")
        completionHandler(.performDefaultHandling, nil)
    }

}

let a = YDCalypso(url: "https://www.httpbin.org/get", httpMethod: "GET")
a.fire()
```
