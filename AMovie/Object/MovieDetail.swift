
import Foundation
class MovieDetail: Codable {
    var voteAverage: Float
    var backgroundImage: String
    var posterImage: String
    var overview: String
    var title: String
    var releaseDate: String
    var runtime: Int
    
    init(voteAverage: Float, backgroundImage: String, posterImage: String, overview: String, title: String, releaseDate: String, runtime: Int) {
        self.voteAverage = voteAverage
        self.backgroundImage = backgroundImage
        self.posterImage = posterImage
        self.overview = overview
        self.title = title
        self.releaseDate = releaseDate
        self.runtime = runtime
        
    }
    private enum CodingKeys : String, CodingKey {
        case overview, runtime
        case voteAverage = "vote_average"
        case backgroundImage = "backdrop_path"
        case posterImage = "poster_path"
        case title = "original_title"
        case releaseDate = "release_date"
    }
}

