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
    
    func minimax(depth: Int) -> (origin: CGPoint, score: Double) {
        var bestScore = Double.infinity
        var currentScore: Double
        var bestPoint: CGPoint?
        if rectsToBeArranged.isEmpty || depth == 0 {
            bestScore = evaluateHeuristics()
        } else {
            let possiblePlaces = getPossiblePlaces()
            for point in possiblePlaces {
                arrangedRects.rects.append(CGRect(origin: point, size: self.rectsToBeArranged.first!.size))
                let triedRect = self.rectsToBeArranged.removeFirst()
                
                currentScore = minimax(depth: depth - 1).score
                if currentScore < bestScore {
                    bestScore = currentScore
                    bestPoint = point
                }
                
                arrangedRects.rects.removeLast()
                rectsToBeArranged.insert(triedRect, at: 0)
            }
        }
        return (bestPoint ?? .zero, bestScore)
    }
    
    func arrange() {
        rectsToBeArranged.sort { (a, b) -> Bool in
            let aArea = a.size.width * a.size.height
            let bArea = b.size.width * b.size.height
            return aArea > bArea
        }
        arrangedRects.rects.append(CGRect(origin: .zero, size: rectsToBeArranged.first!.size))
        rectsToBeArranged.removeFirst()
        while !rectsToBeArranged.isEmpty {
            let point = minimax(depth: 2).origin
            arrangedRects.rects.append(CGRect(origin: point, size: rectsToBeArranged.first!.size))
            let placedRect = rectsToBeArranged.removeFirst()
            let area = placedRect.size.width * placedRect.size.height
            print("Rect Placed")
            print("Area: \(area)")
        }
    }
}
