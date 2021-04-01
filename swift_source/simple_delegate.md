## A simple Delegate
```
import Foundation

protocol RoadRaceDelegate {
    func didStart()
    func didComplete()
}

struct WileyCoyote: RoadRaceDelegate {
    func didStart() {
        print("in didStart")
    }
    func didComplete() {
        print("in didComplete")
    }
}

class YDRoadRunner {
    var counter = 0
    var total = 5
    var delegate: RoadRaceDelegate?

    func longRunningJob() {
        self.delegate?.didStart()

        repeat {
            counter += 1
            sleep(1)
            print(counter)
        }
        while counter < total
        self.delegate?.didComplete()
    }
}

let rr = YDRoadRunner()
let wc = WileyCoyote()
rr.delegate = wc
rr.longRunningJob()
```
