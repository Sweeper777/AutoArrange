import CoreGraphics
import SwiftyUtils

class RectArranger {
    var imagesToBeArranged: PositionedImageCollection
    var arrangedImages = PositionedImageCollection(images: [])
    let idealRatio: Double
    
    init(rects: PositionedImageCollection, idealRatio: Double = 1 / sqrt(2)) {
        self.imagesToBeArranged = rects
        self.idealRatio = idealRatio
    }
    
    func evaluateHeuristics() -> Double {
        if let maxX = (arrangedImages.map { $0.rect.maxX }).max(), let maxY = (arrangedImages.map { $0.rect.maxY }).max() {
            let currentRatio = Double(maxX / maxY)
            let percentageError = (abs(currentRatio - idealRatio)) / idealRatio
            return percentageError
        } else {
            return 0
        }
    }
    
    func getPossiblePlaces() -> [CGPoint] {
        let possiblePlaces = (arrangedImages.flatMap { [
            CGPoint(x: $0.rect.minX, y: $0.rect.maxY),
            CGPoint(x: $0.rect.maxX, y: $0.rect.minY),
            ] })
            .filter { (point) -> Bool in
                let newRect = CGRect(origin: point, size: self.imagesToBeArranged.images.first!.rect.size)
                for image in self.arrangedImages {
                    if image.rect.intersects(newRect) || point.x < 0 || point.y < 0 {
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
        if imagesToBeArranged.images.isEmpty || depth == 0 {
            bestScore = evaluateHeuristics()
        } else {
            let possiblePlaces = getPossiblePlaces()
            for point in possiblePlaces {
                var newImage = self.imagesToBeArranged.images.first!
                newImage.rect = newImage.rect.with(origin: point)
                arrangedImages.images.append(newImage)
                let triedImage = self.imagesToBeArranged.images.removeFirst()
                
                currentScore = minimax(depth: depth - 1).score
                if currentScore < bestScore {
                    bestScore = currentScore
                    bestPoint = point
                }
                
                arrangedImages.images.removeLast()
                imagesToBeArranged.images.insert(triedImage, at: 0)
            }
        }
        return (bestPoint ?? .zero, bestScore)
    }
    
    func arrange() {
        imagesToBeArranged.images.sort { (a, b) -> Bool in
            let aArea = a.rect.width * a.rect.height
            let bArea = b.rect.width * b.rect.height
            return aArea > bArea
        }
        var newImage = imagesToBeArranged.images.first!
        newImage.rect = newImage.rect.with(origin: .zero)
        arrangedImages.images.append(newImage)
        imagesToBeArranged.images.removeFirst()
        while !imagesToBeArranged.images.isEmpty {
            let point = minimax(depth: 2).origin
            var newImage = imagesToBeArranged.images.first!
            newImage.rect = newImage.rect.with(origin: point)
            arrangedImages.images.append(newImage)
            let placedRect = imagesToBeArranged.images.removeFirst()
            let area = placedRect.rect.width * placedRect.rect.height
            print("Rect Placed")
            print("Area: \(area)")
        }
    }
}
