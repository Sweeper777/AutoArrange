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
    func getPossiblePlaces() -> [CGPoint] {
        let possiblePlaces = (arrangedRects.flatMap { [
            CGPoint(x: $0.minX, y: $0.maxY),
            CGPoint(x: $0.maxX, y: $0.minY),
            ] })
            .filter { (point) -> Bool in
                let newRect = CGRect(origin: point, size: self.rectsToBeArranged.first!.size)
                for rect in self.arrangedRects {
                    if rect.intersects(newRect) || point.x < 0 || point.y < 0 {
                        return false
                    }
                }
                return true
        }
        return possiblePlaces
    }
}
