import Foundation

enum YDNetworkError: Error {
        case timeOut
        case noInternet
        case unknownError(Int)
}

extension YDNetworkError {
    init?(receivedError: Error)  {
        switch receivedError._code {
        case NSURLErrorCannotConnectToHost:
            self = .timeOut
        case NSURLErrorTimedOut:
            self = .timeOut
        case NSURLErrorNotConnectedToInternet:
            self = .noInternet
        default:
            self = .unknownError(receivedError._code)
        }
    }
}

extension YDNetworkError: LocalizedError {

    var errorDescription: String? {
        switch self {
        case .noInternet:
            return "🐝 No internet"
        case .timeOut:
            return "🐝 Timeout, no response received"
        case .unknownError:
            return "🐝 non-mapped error.  \(self)"
        }
    }
}

class YDSlimURLSession: NSObject {
    
    enum FetchResult {
        case Success
        case Failure(Error)
    }

    var result: FetchResult
    var url: URL
    
    func SessionType() -> URLSession {
       return URLSession.shared
    }
    
    init(url: URL){
        self.url = url
        self.result = .Failure(YDNetworkError.timeOut)
    }

    func fetchAsyncAwait() -> FetchResult {

        let semaphore = DispatchSemaphore(value: 0)
        SessionType().dataTask(with: url) { (data, resp, error) in
            if let _ = data {
                self.result = .Success
            }
            
            if let error = error {
                let e = YDNetworkError.init(receivedError: error)
                self.result = .Failure(e! as LocalizedError)
            }

            if let response = resp as? HTTPURLResponse {
                print("🐝Status code \(response.statusCode)")
                if let cookies:[HTTPCookie] = HTTPCookieStorage.shared.cookies{
                    for cookie:HTTPCookie in cookies as [HTTPCookie] {
                        print("🐝\(cookie.name)")
                    }
                }
            }
            semaphore.signal()
        }.resume()
        
        let semaphore_result = semaphore.wait(timeout: .now() + 5)
        if semaphore_result == .success
        {
            return result
        }
        else {
            print("🐝 Semaphore timeout")
            self.result = .Failure(YDNetworkError.timeOut)
            return result
        }
    }
}

guard let url = URL(string: "https://httpbin.org/get") else {
    exit(99)
}
let request = YDSlimURLSession.init(url:url)
let result = request.fetchAsyncAwait()

switch result {
    case .Success:
        print("success")
    case .Failure(let error):
        print("Error code: \(error.localizedDescription)")
}

