import UIKit

class DataPasserController: UINavigationController {
    var selectedImages: [UIImage]!
    
    override func viewDidLoad() {
        if let vc = self.topViewController as? ArrangementEditorController {
            vc.images = self.selectedImages
        }
    }
}
