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
    }
    
    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
}
