## A Live Playground for macOS NSViewController
```
// https://www.hackingwithswift.com/example-code/uikit/how-to-create-live-playgrounds-in-xcode
// assistant editor by pressing Alt+Cmd+Return

import PlaygroundSupport
import Cocoa

class PVC: NSViewController {
    var textField: NSTextField?

    override func loadView() {
        print("Loading view")
        view = NSView(frame: NSRect(x: 0, y: 0, width: 300, height: 300))
        view.wantsLayer = true
        view.layer?.backgroundColor = CGColor.white

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("did load")
        textField = NSTextField(frame: NSRect(x: 10, y: 10, width: 100, height: 100))
        textField!.isBezeled = false
        textField!.drawsBackground = true
        textField!.isEditable = false
        textField!.isSelectable = false
        textField!.stringValue = "TEST"
        self.view.addSubview(textField!)
    }

}
let vc = PVC()
PlaygroundPage.current.liveView = vc
```
