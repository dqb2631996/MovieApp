import UIKit

class ListMovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var nameMovieLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    var dataTaskBGImage: URLSessionDataTask?
    var dataTaskPosterImage: URLSessionDataTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dataTaskBGImage?.cancel()
        dataTaskPosterImage?.cancel()
        posterImage.image = nil
        backGroundImage.image = nil
    }
    
    func configCell() {
        posterImage.layer.cornerRadius = posterImage.frame.height / 2
        posterImage.clipsToBounds = true
    }
    
    func fillData(with movie: Movie?) {
//        posterImage.getImageFromUrl(url: movie?.posterImage ?? "" )
//        backGroundImage.getImageFromUrl(url: movie?.backgroundImage ?? "")
        dataTaskPosterImage = posterImage.loadImageFromUrl(imageUrl: movie?.posterImage?.mergeUrl ?? "")
        dataTaskBGImage = backGroundImage.loadImageFromUrl(imageUrl: movie?.backgroundImage?.mergeUrl ?? "")
        nameMovieLabel.text = movie?.title
        popularityLabel.text = "Popularity \(movie?.popularity ?? 0)"
    }
}

