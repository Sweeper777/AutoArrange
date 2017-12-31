protocol RectArrangerDelegate: class {
    func rectArranger(didFinishArrangement arranger: RectArranger)
    
    func rectArranger(didPlaceRect arranger: RectArranger, rectCount: Int)
    
    func rectArranger(didStartArranging arranger: RectArranger)
}
