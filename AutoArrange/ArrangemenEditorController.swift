import UIKit
import Eureka
import ViewRow

class ArrangementEditorController : FormViewController {
    var images: [UIImage]!
    
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
}
