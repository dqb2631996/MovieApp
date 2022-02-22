import Foundation

enum SortType: CaseIterable {
    case popularity
    case releaseDate
    case aToZ       
    
    var title: String {
        switch self {
        case .releaseDate:
            return "Release Date"
        case .aToZ:
            return "A - Z"
        case .popularity:
            return "Popularity"
        }
    }
    var apiParam: String {
        switch self {
        case .releaseDate:
            return "release_date.desc"
        case .aToZ:
            return "original_title.asc"
        case .popularity:
            return "popularity.desc"
        }
    }
}
