import UIKit
import Eureka

class ArrangementEditorController : FormViewController {
    var images: [UIImage]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        for image in images {
            form +++ Section()
        }
    }
    
    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
}
