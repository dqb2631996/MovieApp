import UIKit

class MovieDetailViewController: UIViewController {
    @IBOutlet private weak var actorCollectionView: UICollectionView!
    @IBOutlet private weak var backGroundImageView: UIImageView!
    @IBOutlet private weak var avatarImage: UIImageView!
    
    @IBOutlet private weak var star1Image: UIImageView!
    @IBOutlet private weak var star2Image: UIImageView!
    @IBOutlet private weak var star3Image: UIImageView!
    @IBOutlet private weak var star4Image: UIImageView!
    @IBOutlet private weak var star5Image: UIImageView!
    
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var nameMovieLabel: UILabel!
    var id: Int?
    var movieDetail: MovieDetail?
    var movieCredits: MovieCredits?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configActorCollectionView()
        fetchMovieDetails()
        fetchCastsOfMovie()
    }
    @IBAction func didTapPopToHomeScreenButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: UICollectionViewDataSource
extension MovieDetailViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieCredits?.cast.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: MovieDetailCollectionViewCell.self, for: indexPath)
        
        if let movieCast = movieCredits?.cast,
            movieCast.indices ~= indexPath.row {
            cell.avatarActorImage.getImageFromUrl(url: movieCast[indexPath.row].backgroundImage ?? "")
        }
        return cell
    }
}
//MARK: UICollectionViewDelegateFlowLayout
extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}
//MARK: Fetch data
extension MovieDetailViewController {
    func configActorCollectionView() {
        actorCollectionView.dataSource = self
        actorCollectionView.delegate = self
        actorCollectionView.registerNib(cellName: MovieDetailCollectionViewCell.className)
    }
    
    func updateStartImages() {
        guard let voteAverage = movieDetail?.voteAverage
            else { return }
        var starImageViewList = [star1Image, star2Image, star3Image, star4Image, star5Image]
        let star = ( Int(voteAverage ) / 2 )
        let subtraction = (voteAverage / 2) - Float(star)
        DispatchQueue.main.async {
            for index in 0..<starImageViewList.count {
                starImageViewList[index]?.image = index < star ? UIImage(named: "starbl") : UIImage(named: "starw")
                if subtraction >= 0.5 {
                    starImageViewList[star]?.image = UIImage(named: "star")
                }
            }
        }
        if let posterImage = movieDetail?.posterImage {
            avatarImage.getImageFromUrl(url: posterImage)
        }
        if let backdropImage = movieDetail?.backgroundImage {
            backGroundImageView.getImageFromUrl(url: backdropImage)
        }
        nameMovieLabel.text = movieDetail?.title
        dateLabel.text = movieDetail?.releaseDate
        timeLabel.text = "\(movieDetail?.runtime ?? 0) minutes"
        if let overview = movieDetail?.overview {
            overviewLabel.text = "OVERVIEW : \n\(overview)"
        }
    }
    
    func fetchMovieDetails() {
        if let id = id {
            NetworkManager.shared.getMovieDetailData(id: id) { movieDetail in
                self.movieDetail = movieDetail
                DispatchQueue.main.async {
                    self.updateStartImages()
                }
            }
        }
    }
    
    func fetchCastsOfMovie() {
        if let id = id {
            NetworkManager.shared.getCastMovieDetailData(id: id) { movieCredits in
                self.movieCredits = movieCredits
                DispatchQueue.main.async {
                    self.actorCollectionView.reloadData()
                }
            }
        }
    }
}
