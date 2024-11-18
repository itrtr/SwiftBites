import Foundation
enum RecipeSortOption {
    case name
    case servingAscending
    case servingDescending
    case timeAscending
    case timeDescending
    
    var title: String {
        switch self {
        case .name: return "Name"
        case .servingAscending: return "Serving (low to high)"
        case .servingDescending: return "Serving (high to low)"
        case .timeAscending: return "Time (short to long)"
        case .timeDescending: return "Time (long to short)"
        }
    }
}
