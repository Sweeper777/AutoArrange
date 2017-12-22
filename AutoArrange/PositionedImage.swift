import UIKit

struct PositionedImage: Codable {
    let image: UIImage
    var rect: CGRect
    
    init(image: UIImage, rect: CGRect) {
        self.image = image
        self.rect = rect
    }
    
}
