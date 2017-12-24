import UIKit

struct PositionedImage: Codable {
    let image: UIImage
    var rect: CGRect
    var scaleFactor: Double
    
    init(image: UIImage, rect: CGRect, scaleFactor: Double) {
        self.image = image
        self.rect = rect
        self.scaleFactor = scaleFactor
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        image = try UIImage(data: container.decode(Data.self, forKey: .image))!
        rect = try container.decode(CGRect.self, forKey: .rect)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(UIImagePNGRepresentation(image), forKey: .image)
        try container.encode(rect, forKey: .rect)
    }
    
    enum CodingKeys: CodingKey {
        case image
        case rect
    }
}
