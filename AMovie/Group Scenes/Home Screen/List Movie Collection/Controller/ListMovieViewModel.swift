
import Foundation
final class ListMovieViewModel {
    var discoverMovieResponse: DiscoverMovieResponse?
    private var pageNumber = 1
    private var isLoading = false
    private var countSearch = 0
    var sortType: SortType = .popularity
    var reloadTableView: (() -> ())?
    
    func fetchMoviesData() {
        pageNumber = 1
        NetworkManager.shared.getMovieData(page: pageNumber, sortType: sortType) { discoverMovie in
            self.discoverMovieResponse = discoverMovie
            self.reloadTableView?()
        }
    }
    
    func loadMoreData() {
        pageNumber += 1
        if !isLoading {
            isLoading = true
            NetworkManager.shared.getMovieData(page: pageNumber, sortType: sortType) { discoverMovie in
                self.discoverMovieResponse?.results += discoverMovie.results
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                    self.isLoading = false
//                }
                self.reloadTableView?()
            }
        }
    }
    
    func getNumberOfRows(_ section: Int) -> Int {
        if discoverMovieResponse?.results.count != 0 {
            return discoverMovieResponse?.results.count ?? 0
        }
        return 0
    }
    
    func getCellForRow (_ indexPath: IndexPath) -> Movie {
        return (discoverMovieResponse?.results[indexPath.row])!
    }
    
    func countRow(_ indexPath: IndexPath) -> Int {
        return  discoverMovieResponse?.results.count ?? 0
    }
    
    func changeSortType(index: Int) {
        sortType = SortType.allCases[index]
    }
}
