import CoreGraphics

struct RectCollection: Sequence {
    var rects: [CGRect] = []
    
    init(rects: [CGRect]) {
        self.rects = rects
    }
}
