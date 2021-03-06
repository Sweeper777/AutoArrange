import UIKit
import Eureka
import ViewRow
import EZLoadingActivity

class ArrangementEditorController : FormViewController {
    var images: [UIImage]!
    var arranger: RectArranger!
    var arrangement: Arrangement!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem?.title = ""
        
        form +++ Section()
        <<< TextRow(tagName) {
            row in
            row.title = NSLocalizedString("Name", comment: "")
            row.placeholder = NSLocalizedString("Unnamed", comment: "")
        }
        <<< DecimalRow(tagMargin) {
            row in
            row.title = NSLocalizedString("Margin (px)", comment: "")
            row.placeholder = "5.0"
        }
        
        <<< SegmentedRow<WHRatios>(tagWHRatio) {
            row in
            row.options = [.landscape, .portrait]
            row.value = .portrait
            row.title = NSLocalizedString("Orientation", comment: "")
        }
        
        for (index, image) in self.images.enumerated() {
            form +++ Section()
            <<< ViewRow() {
                row in
            }.cellSetup { (cell, row) in
                let imageView = UIImageView(image: image)
                imageView.contentMode = .scaleAspectFit
                cell.view = imageView
                cell.contentView.addSubview(cell.view!)
                
                cell.height = { 200 }
            }
            <<< DecimalRow(tagScaleFactor + String(index)) {
                row in
                row.value = 1
                row.placeholder = "1.0"
                row.title = NSLocalizedString("Scale Factor", comment: "")
            }
        }
    }
    
    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func arrange() {
        let values = form.values(includeHidden: false)
        arrangement = Arrangement()
        if let name = values[tagName] as? String {
            arrangement.name = name
        }
        if let margin = values[tagMargin] as? Double {
            arrangement.margin = margin
        }
        if let ratio = values[tagWHRatio] as? WHRatios {
            arrangement.ratio = ratio.ratio
        }
        
        func size(of image: UIImage, scaleFactor: Double) -> CGSize {
            let scaled = image.size.applying(CGAffineTransform(scaleX: scaleFactor.f, y: scaleFactor.f))
            return CGSize(width: scaled.width + arrangement.margin.f * 2, height: scaled.height + arrangement.margin.f * 2)
        }
        
        var positionedImages = [PositionedImage]()
        for (index, image) in images.enumerated() {
            let scale = values[tagScaleFactor + String(index)] as? Double
            let imageSize = size(of: image, scaleFactor: scale ?? 1)
            positionedImages.append(PositionedImage(image: image, rect: CGRect(origin: .zero, size: imageSize), scaleFactor: scale ?? 1))
        }
        arranger = RectArranger(rects: PositionedImageCollection(images: positionedImages), idealRatio: arrangement.ratio)
        arranger.delegate = self
        EZLoadingActivity.show(String.init(format: NSLocalizedString("%@ Images Arranged", comment: ""), 0) , disableUI: true)
        DispatchQueue.main.async {
            [weak self] in
            self?.arranger.arrange()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ArrangementPreviewController {
            let encoder = PropertyListEncoder()
            encoder.outputFormat = .binary
            arrangement.imagesData = try! encoder.encode(sender as! PositionedImageCollection)
            vc.arrangement = arrangement
        }
    }
}

extension ArrangementEditorController : RectArrangerDelegate {
    func rectArranger(didFinishArrangement arranger: RectArranger) {
        EZLoadingActivity.hide(true, animated: true)
        
        performSegue(withIdentifier: "showArrangementPreview", sender: arranger.arrangedImages)
    }
    
    func rectArranger(didPlaceRect arranger: RectArranger, rectCount: Int) {
        DispatchQueue.main.async {
            EZLoadingActivity.show(String.init(format: NSLocalizedString("%d Images Arranged", comment: ""), rectCount) , disableUI: true)
        }
    }
    
    func rectArranger(didStartArranging arranger: RectArranger) {
    }
}
