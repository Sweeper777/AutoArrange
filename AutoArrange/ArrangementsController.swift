import UIKit
import TLPhotoPicker

class ArrangementsController: UITableViewController, TLPhotosPickerViewControllerDelegate {
    
    var selectedImages: [UIImage]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func newArrangement() {
        let vc = TLPhotosPickerViewController()
        vc.delegate = self
        var configure = TLPhotosPickerConfigure()
        configure.defaultCameraRollTitle = NSLocalizedString("Camera Roll", comment: "")
        configure.tapHereToChange = NSLocalizedString("Tap here to change", comment: "")
        configure.allowedVideo = false
        configure.allowedLivePhotos = false
        configure.allowedVideoRecording = false
        vc.configure = configure
        self.present(vc, animated: true, completion: nil)
    }
    
    func dismissPhotoPicker(withTLPHAssets: [TLPHAsset]) {
        selectedImages = withTLPHAssets.map { $0.fullResolutionImage! }
    }
    
    func dismissComplete() {
        performSegue(withIdentifier: "showArrangementEditor", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DataPasserController {
            vc.selectedImages = self.selectedImages
        }
    }
}

