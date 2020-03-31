import UIKit
import PlaygroundSupport

// https://www.youtube.com/watch?v=M4n7u0txGDM&t=443s

class fooBarAsync: Operation{
    enum State: String {
        case Ready, Executing, Finished
        
        fileprivate var keyPath: String {
            return "is" + rawValue
        }
    }
    var state = State.Ready{
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
}
extension fooBarAsync {
    override var isReady: Bool {
        return super.isReady && state == .Ready
    }
    override var isExecuting: Bool {
        return state == .Executing
    }
    override var isFinished: Bool {
        return state == .Finished
    }
    override var isAsynchronous: Bool{
        return true
    }
    
    override func start() {
        if isCancelled {
            state = .Finished
            return
        }
        main()
        state = .Executing
    }
    override func cancel() {
        state = .Finished
    }
}

class SumOperation: fooBarAsync {
    let lhs: Int
    let rhs: Int
    var result: Int?
    
    init(lhs: Int, rhs: Int) {
        self.lhs = lhs
        self.rhs = rhs
        super.init()
    }
    override func main() {
        asyncAdd_OpQ(lhs: lhs, rhs: rhs) { result in
            self.result = result
            self.state = .Finished
        }
    }
}

public func asyncAdd_OpQ(lhs: Int, rhs: Int, callback: @escaping (Int) -> ()) {
  additionQueue.addOperation {
    sleep(1)
    callback(lhs + rhs)
  }
}

let additionQueue = OperationQueue()

let input = [(1,5), (5,8), (6,1), (3,9), (6,12), (1,0)]
for (lhs, rhs) in input {

  let operation = SumOperation(lhs: lhs, rhs: rhs)
  operation.completionBlock = {
    guard let result = operation.result else { return }
    print("\(lhs) + \(rhs) = \(result)")
  }
  
  additionQueue.addOperation(operation)
}

