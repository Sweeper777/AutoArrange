import UIKit
import Eureka

class ArrangementEditorController : FormViewController {
    var images: [UIImage]!
    
    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
}
