import CoreGraphics

class RectArranger {
    var rectsToBeArranged: [CGRect]
    var arrangedRects = RectCollection(rects: [])
    let idealRatio: Double
    
    init(rects: [CGRect], idealRatio: Double = 1 / sqrt(2)) {
        self.rectsToBeArranged = rects
        self.idealRatio = idealRatio
    }
    
    func evaluateHeuristics() -> Double {
        if let maxX = (arrangedRects.map { $0.maxX }).max(), let maxY = (arrangedRects.map { $0.maxY }).max() {
            let currentRatio = Double(maxX / maxY)
            let percentageError = (abs(currentRatio - idealRatio)) / idealRatio
            return percentageError
        } else {
            return 0
        }
    }
}
