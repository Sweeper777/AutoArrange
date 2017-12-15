import CoreGraphics

class RectArranger {
    var rectsToBeArranged: [CGRect]
    var arrangedRects = RectCollection(rects: [])
    let idealRatio: Double
    
    init(rects: [CGRect], idealRatio: Double = 1 / sqrt(2)) {
        self.rectsToBeArranged = rects
        self.idealRatio = idealRatio
    }
    
}
