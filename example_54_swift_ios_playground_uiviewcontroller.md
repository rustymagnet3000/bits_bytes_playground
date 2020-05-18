## A Live Playground for iOS UIViewController
```
import UIKit
import PlaygroundSupport

class PGViewController : UIViewController {

    let message: String

    init(message: String) {
        self.message = message
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    override func loadView() {

        let view = UIView()
        view.backgroundColor = .brown

        let label = UILabel()
        label.backgroundColor = .yellow
        label.textAlignment = .center
        label.layer.cornerRadius = 48
        label.layer.masksToBounds = true

        let message = "Polite"
        let font = UIFont.systemFont(ofSize: 72)

        let shadow = NSShadow()
        shadow.shadowBlurRadius = 3
        shadow.shadowOffset = CGSize(width: 3, height: 3)
        shadow.shadowColor = UIColor.blue

        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.lightGray,
            .shadow: shadow
        ]

        let attributedMsg = NSAttributedString(string: message, attributes: attributes)
        label.attributedText = attributedMsg

        view.addSubview(label)



        label.translatesAutoresizingMaskIntoConstraints = false

        let widthConstraint = NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal,
                                                 toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 250)

        let heightConstraint = NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal,
                                                  toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)

        let xConstraint = NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)

        let yConstraint = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)

        NSLayoutConstraint.activate([widthConstraint, heightConstraint, xConstraint, yConstraint])

        self.view = view
    }

}

PlaygroundPage.current.liveView = PGViewController(message: "Polite")
