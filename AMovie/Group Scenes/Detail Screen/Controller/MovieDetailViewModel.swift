import Foundation
final class MovieDetailViewModel {
    var id: Int?
    var movieDetail: MovieDetail?
    var movieCredits: MovieCredits?
    
    func fetchMovieDetails() {
        if let id = id {
            NetworkManager.shared.getMovieDetailData(id: id) { movieDetail in
                self.movieDetail = movieDetail
            }
        }
    }
    
    func fetchCastsOfMovie() {
        if let id = id {
            NetworkManager.shared.getCastMovieDetailData(id: id) { movieCredits in
                self.movieCredits = movieCredits
            }
        }
    }
    func getNumberOfRows(_ section: Int) -> Int {
        if movieCredits?.cast.count != 0 {
            return movieCredits?.cast.count ?? 0
        }
        return 0
    }
    
    func getCellForRow (_ indexPath: IndexPath) -> Cast {
        return ((movieCredits?.cast[indexPath.row])!)
    }
}
