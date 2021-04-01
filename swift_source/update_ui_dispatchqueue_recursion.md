## DispatchQueue
#### UILabel with Counter
```
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!

    var counter:Int = 0 {
        didSet {
            print("old value \(oldValue) and new value: \(counter). Main thread: \(Thread.isMainThread)")
            label.text = String(counter)
        }
    }

    @IBAction func start_btn(_ sender: Any) {
        updateCounter()
    }

    func updateCounter() {
        guard counter < 3 else { return }

        counter += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.updateCounter()
            })
    }
}
```
