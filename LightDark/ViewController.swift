
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var secondaryView: UIView!
    
    let dynamicColor = UIColor {(traitCollection: UITraitCollection) -> UIColor in
        if traitCollection.userInterfaceStyle == .dark {
            return .yellow
        } else {
            return .blue
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.secondaryView.backgroundColor = dynamicColor
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            // Manually resolving colors
            let layer = CALayer()
            let traitCollection = view.traitCollection
            
            // 1 - ask color to resolve itself
            let resolvedColor = UIColor.label.resolvedColor(with: traitCollection)
            layer.borderColor = resolvedColor.cgColor
            
            // 2 - current for closure
            traitCollection.performAsCurrent {
                layer.borderColor = UIColor.label.cgColor
            }
            
            // 3 - directly set current
            let savedTraitCollection = UITraitCollection.current
            
            UITraitCollection.current = traitCollection
            layer.borderColor = UIColor.label.cgColor
            
            UITraitCollection.current = savedTraitCollection
            
            let image = UIImage(named: "sampleIMG")
            let asset = image?.imageAsset
            let resolvedImg = asset?.image(with: traitCollection)
        }
    }
}

