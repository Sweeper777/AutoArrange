import UIKit

struct PositionedImage: Codable {
    let image: UIImage
    var rect: CGRect
    
    init(image: UIImage, rect: CGRect) {
        self.image = image
        self.rect = rect
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        image = try UIImage(data: container.decode(Data.self, forKey: .image))!
        rect = try container.decode(CGRect.self, forKey: .rect)
    }
    
    
    enum CodingKeys: CodingKey {
        case image
        case rect
    }
}
