import UIKit

class ArrangementPreviewController: UIViewController {
    var arrangement: Arrangement!
    
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        let decoder = PropertyListDecoder()
        let imageCollection = try! decoder.decode(PositionedImageCollection.self, from: arrangement.imagesData!)
        for positionedImage in imageCollection {
            let imageRect = CGRect(
                x: positionedImage.rect.x + arrangement.margin.f,
                y: positionedImage.rect.y + arrangement.margin.f,
                width: positionedImage.rect.width - arrangement.margin.f * 2,
                height: positionedImage.rect.height - arrangement.margin.f * 2)
            let imageView = UIImageView(frame: imageRect)
        }
    }
}
