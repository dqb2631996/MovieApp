import UIKit
fileprivate struct DefinesHeight {
    static let movieTableRowHeight: CGFloat = 320
}

class ListMovieViewController: UIViewController {
    
    @IBOutlet weak var heightSortView: NSLayoutConstraint!
    
    @IBOutlet weak var sortCollectionView: UICollectionView!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet private weak var listMovieTableView: UITableView!
    
    var arraySort = SortType.allCases
    var countSort = 0
    private let refreshControl = UIRefreshControl()
    var listMovieViewModel = ListMovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        fetchMoviesData()
        
    }
    
    @IBAction func didTapSearchMoviesDataButton(_ sender: UIButton) {
        updateSortView()
    }
}
//MARK: Fetch data
extension ListMovieViewController {
    private func fetchMoviesData() {
        listMovieViewModel.fetchMoviesData()
        print(4)
    }
    
    func loadMoreData() {
        listMovieViewModel.loadMoreData()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.listMovieTableView.reloadData()
//        }
    }
}
//MARK: Configure view
extension ListMovieViewController {
    private func configView() {
        configCollectionView()
        configTableView()
        configRefreshControl()
        configViewModel()
    }
    
    private func configTableView() {
        listMovieTableView.dataSource = self
        listMovieTableView.delegate = self
        listMovieTableView.registerNib(cellName: ListMovieTableViewCell.className)
        listMovieTableView.registerNib(cellName: ListMovieLoadingTableViewCell.className)
    }
    
    private func configCollectionView() {
        sortCollectionView.delegate = self
        sortCollectionView.dataSource = self
        
        sortCollectionView.registerNib(cellName: SortMovieCollectionViewCell.className)
    }
    
    func configViewModel() {
        listMovieViewModel.reloadTableView = {
            DispatchQueue.main.async { [weak self] in
                self?.listMovieTableView.reloadData()
            }
        }
    }
    
    private func configRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        listMovieTableView.addSubview(refreshControl)
    }
    
    @objc private func refreshTableView() {
        fetchMoviesData()
        DispatchQueue.main.async { [weak self] in
            self?.listMovieTableView.reloadData()
            self?.refreshControl.endRefreshing()
        }
    }
    
    func gotoDetailPage(_ movie: Movie) {
        let movieDetailVC = MovieDetailViewController()
        movieDetailVC.id = movie.id
        self.navigationController?.pushViewController(movieDetailVC, animated: true)
    }
}
// MARK : TableView DataSource
extension ListMovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return listMovieViewModel.getNumberOfRows(section)
        } else if section == 1 {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == listMovieViewModel.discoverMovieResponse?.results.count {
            loadMoreData()
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = listMovieTableView.dequeueReusableCell(withClass: ListMovieTableViewCell.self, for: indexPath)
            if let movies = listMovieViewModel.discoverMovieResponse?.results,
                movies.indices ~= indexPath.row {
                let movie = listMovieViewModel.getCellForRow(indexPath)
                cell.fillData(with: movie)
            }
            return cell
        } else {
            let cell = listMovieTableView.dequeueReusableCell(withClass: ListMovieLoadingTableViewCell.self, for: indexPath)
            cell.activityIndicator.startAnimating()
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}
//MARK: TableView Delegate
extension ListMovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return DefinesHeight.movieTableRowHeight
        } else {
            return DefinesHeight.movieTableRowHeight / 6
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = listMovieViewModel.getCellForRow(indexPath)
        countSort = 1
        updateSortView()
        countSort = 0
        gotoDetailPage(movie)
    }
}
//MARK: SortView
extension ListMovieViewController {
    func updateSortView() {
        countSort = countSort + 1
        if countSort % 2 != 0 {
            sortButton.setImage(UIImage(named: "sort.up"), for: .normal)
            heightSortView.constant = 116
        } else {
            heightSortView.constant = 32
            sortButton.setImage(UIImage(named: "sort.down"), for: .normal)
        }
    }
}

//MARK: SortView Collection
extension ListMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arraySort.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = sortCollectionView.dequeueReusableCell(withClass: SortMovieCollectionViewCell.self, for: indexPath)
        cell.sortLabel.text = arraySort[indexPath.row].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        listMovieViewModel.sortType = arraySort[indexPath.row]
        fetchMoviesData()
        arraySort.insert(arraySort[indexPath.row], at: 0)
        arraySort.remove(at: indexPath.row + 1)
        updateSortView()
        countSort = 0
        sortCollectionView.reloadData()
    }
}
