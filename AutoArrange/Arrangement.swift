import RealmSwift

class Arrangement: Object {
    @objc dynamic var name = NSLocalizedString("Unnamed ", comment: "")
    @objc dynamic var imagesData: Data?
    @objc dynamic var margin = 7.0
    @objc dynamic var ratio = 1 / sqrt(2)
}
