import Darwin

enum WHRatios : String {
    case landscape = "Landscape"
    case portrait = "Portrait"
    
    var ratio: Double {
        switch self {
        case .landscape:
            return sqrt(2)
        case .portrait:
            return 1 / sqrt(2)
        }
    }
}
