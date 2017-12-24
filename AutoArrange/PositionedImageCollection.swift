import CoreGraphics

struct PositionedImageCollection: Sequence, Codable {
    typealias Iterator = Array<PositionedImage>.Iterator
    typealias SubSequence = Array<PositionedImage>.SubSequence
    
    public func makeIterator() -> Iterator {
        return images.makeIterator()
    }
    
    public var underestimatedCount: Int {
        return images.underestimatedCount
    }
    
    public func map<T>(_ transform: (Iterator.Element) throws -> T) rethrows -> [T] {
        return try images.map(transform)
    }
    public func filter(_ isIncluded: (Iterator.Element) throws -> Bool) rethrows -> [Iterator.Element] {
        return try images.filter(isIncluded)
    }
    
    public func forEach(_ body: (Iterator.Element) throws -> Swift.Void) rethrows {
        try images.forEach(body)
    }
    public func dropFirst(_ n: Int) -> SubSequence {
        return images.dropFirst(n)
    }
    public func dropLast(_ n: Int) -> SubSequence {
        return images.dropLast(n)
    }
    
    public func drop(while predicate: (Iterator.Element) throws -> Bool) rethrows -> SubSequence {
        return try images.drop(while: predicate)
    }
    
    public func prefix(_ maxLength: Int) -> SubSequence {
        return images.prefix(maxLength)
    }
    
    public func prefix(while predicate: (Iterator.Element) throws -> Bool) rethrows -> SubSequence {
        return try images.prefix(while: predicate)
    }
    
    public func suffix(_ maxLength: Int) -> SubSequence {
        return images.suffix(maxLength)
    }
    
    public func split(maxSplits: Int, omittingEmptySubsequences: Bool, whereSeparator isSeparator: (Iterator.Element) throws -> Bool) rethrows -> [SubSequence] {
        return try self.images.split(maxSplits: maxSplits, omittingEmptySubsequences: omittingEmptySubsequences, whereSeparator: isSeparator)
    }
    
    var images: [PositionedImage] = []
    
    init(images: [PositionedImage]) {
        self.images = images
    }
    
    
}

