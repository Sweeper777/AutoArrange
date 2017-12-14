import CoreGraphics

struct RectCollection: Sequence {
    typealias Iterator = Array<CGRect>.Iterator
    typealias SubSequence = Array<CGRect>.SubSequence
    
    public func makeIterator() -> Iterator {
        return rects.makeIterator()
    }
    
    public var underestimatedCount: Int {
        return rects.underestimatedCount
    }
    
    public func map<T>(_ transform: (Iterator.Element) throws -> T) rethrows -> [T] {
        return try rects.map(transform)
    }
    public func filter(_ isIncluded: (Iterator.Element) throws -> Bool) rethrows -> [Iterator.Element] {
        return try rects.filter(isIncluded)
    }
    
    public func forEach(_ body: (Iterator.Element) throws -> Swift.Void) rethrows {
        try rects.forEach(body)
    }
    public func dropFirst(_ n: Int) -> SubSequence {
        return rects.dropFirst(n)
    }
    public func dropLast(_ n: Int) -> SubSequence {
        return rects.dropLast(n)
    }
    
    public func drop(while predicate: (Iterator.Element) throws -> Bool) rethrows -> SubSequence {
        return try rects.drop(while: predicate)
    }
    
    public func prefix(_ maxLength: Int) -> SubSequence {
        return rects.prefix(maxLength)
    }
    
    public func prefix(while predicate: (Iterator.Element) throws -> Bool) rethrows -> SubSequence {
        return try rects.prefix(while: predicate)
    }
    
    public func suffix(_ maxLength: Int) -> SubSequence {
        return rects.suffix(maxLength)
    }
    
    public func split(maxSplits: Int, omittingEmptySubsequences: Bool, whereSeparator isSeparator: (Iterator.Element) throws -> Bool) rethrows -> [SubSequence] {
        return try self.rects.split(maxSplits: maxSplits, omittingEmptySubsequences: omittingEmptySubsequences, whereSeparator: isSeparator)
    }
    
    var rects: [CGRect] = []
    
    init(rects: [CGRect]) {
        self.rects = rects
    }
}

