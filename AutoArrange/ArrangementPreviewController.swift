import UIKit

class ArrangementPreviewController: UIViewController {
    var arrangement: Arrangement!
    
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        let decoder = PropertyListDecoder()
        let imageCollection = try! decoder.decode(PositionedImageCollection.self, from: arrangement.imagesData!)
    }
}
