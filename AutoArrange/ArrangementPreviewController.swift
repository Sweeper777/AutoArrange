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
            imageView.image = positionedImage.image
            imageView.contentMode = .scaleAspectFit
            scrollView.addSubview(imageView)
        }
        scrollView.contentSize = CGSize(
            width: imageCollection.map { $0.rect.maxX }.max() ?? 0,
            height: imageCollection.map { $0.rect.maxY }.max() ?? 0)
    }
}
